//
//  RequestManager.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation
import os

/// Type representing HTTP request headers.
public typealias RequestHeaders = [String: String]

/// Type representing a network response, containing a status code and optional data.
public typealias NetworkResponse = (statusCode: Int, data: Data?)

/// Type representing request parameters.
public typealias RequestParameters = [String: Any]

/// Type representing an array of parameters.
typealias ParametersArray = [(key: String, value: Any)]

/// Class responsible for managing network requests.
class RequestManager {
	
	// MARK: - Singleton
	static let shared = RequestManager()
	
	// MARK: - Init
	private init() { }
	
	// MARK: - Build
	
	/// Builds the URL for the given request.
	///
	/// - Parameter request: The request for which to build the URL.
	/// - Returns: The URL constructed from the request parameters.
	/// - Throws: An error if the URL cannot be constructed.
	///
	/// This method constructs a URL based on the parameters of the provided request. It sets the scheme, host, path, and port of the URL from the corresponding properties of the request. If the request encoding is URL-encoded, it appends the request parameters as query items to the URL. Additionally, it appends any URL query items specified by the request authentication. If the resulting URL is nil, it throws a URL construction error.
	///
	/// Example usage:
	/// ```swift
	/// do {
	///     let url = try buildUrl(for: request)
	///     // Use the constructed URL
	/// } catch {
	///     // Handle URL construction error
	/// }
	/// ```
	private func buildUrl(for request: RequestProtocol) throws -> URL {
		var components = URLComponents()
		var finalUrlParameters: [URLQueryItem] = []
		
		components.scheme = request.scheme
		components.host = request.host
		components.path = request.path
		components.port = request.port
		
		switch request.encoding {
		case .url:
			request.parameters?.forEach {
				finalUrlParameters.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
			}
			
		default:
			break
		}
		
		request.authentification?.urlQueryItems.forEach { query in
			if !finalUrlParameters.contains(where: { $0.name == query.name }) {
				finalUrlParameters.append(query)
			}
		}
		
		if !finalUrlParameters.isEmpty {
			components.queryItems = finalUrlParameters
		}
		
		guard let url = components.url
		else { throw RequestError.url }
		
		return url
	}
	
	/// Builds the headers for the given request.
	///
	/// - Parameter request: The request for which to build the headers.
	/// - Returns: The headers constructed from the request parameters.
	///
	/// This method constructs headers based on the parameters of the provided request. It combines authentication headers, if present, with custom headers specified by the request. If no custom headers are specified, it returns only the authentication headers. If no authentication headers are present, it returns an empty dictionary.
	///
	/// Example usage:
	/// ```swift
	/// let headers = buildHeaders(for: request)
	/// // Use the constructed headers
	/// ```
	private func buildHeaders(for request: RequestProtocol) -> RequestHeaders {
		var finalHeaders: RequestHeaders = request.authentification?.headers ?? [:]
		
		// Headers
		request.headers?.forEach {
			finalHeaders[$0.key] = $0.value
		}
		
		return finalHeaders
	}
	
	/// Builds JSON body data for the given request.
	///
	/// - Parameter request: The request for which to build the JSON body data.
	/// - Returns: The JSON body data constructed from the request parameters, or nil if no body data could be constructed.
	///
	/// This method constructs JSON body data based on the parameters of the provided request. It combines authentication body parameters, if present, with custom body parameters specified by the request. If no custom body parameters are specified, it returns only the authentication body parameters. If the resulting body parameters are not empty and can be serialized to JSON, it returns the JSON data. If serialization fails, it logs an error and returns nil.
	///
	/// Example usage:
	/// ```swift
	/// if let jsonData = buildJSONBodyData(for: request) {
	///     // Use the constructed JSON body data
	/// }
	/// ```
	private func buildJSONBodyData(for request: RequestProtocol) -> Data? {
		var finalBodyParameters: RequestParameters = request.authentification?.bodyParameters ?? [:]
		
		// Parameters
		request.parameters?.forEach {
			finalBodyParameters[$0.key] = $0.value
		}
		
		if !finalBodyParameters.isEmpty {
			if JSONSerialization.isValidJSONObject(finalBodyParameters) {
				do {
					return try JSONSerialization.data(withJSONObject: finalBodyParameters, options: [])
				} catch {
					Logger.network.fault("\(RequestError.json): \(error)")
				}
			} else {
				Logger.network.fault("\(RequestError.json)")
			}
		}
		
		return nil
	}
	
	private func buildFormEncodedBodyData(for request: RequestProtocol) -> Data? {
		var finalBodyParameters: RequestParameters = request.authentification?.bodyParameters ?? [:]
		
		// Parameters
		request.parameters?.forEach {
			finalBodyParameters[$0.key] = $0.value
		}
		
		if !finalBodyParameters.isEmpty {
			if JSONSerialization.isValidJSONObject(finalBodyParameters) {
				var requestBody = URLComponents()
				requestBody.queryItems = finalBodyParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
				return requestBody.query?.data(using: .utf8)
			}
			
			Logger.network.fault("\(RequestError.json)")
		}
		
		return nil
	}
	
	private func buildEncoding(with _request: RequestProtocol, in request: inout URLRequest) {
		switch _request.encoding {
		case .json:
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.httpBody = self.buildJSONBodyData(for: _request)
			
		case .custom(let encode, let body):
			request.setValue(encode, forHTTPHeaderField: "Content-Type")
			request.httpBody = body
			
		case .formURLEncoded:
			request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
			request.httpBody = self.buildFormEncodedBodyData(for: _request)
			
		default:
			break
		}
	}
	
	// MARK: - Response
	
	/// Asynchronously retrieves the network response for the given request.
	///
	/// - Parameters:
	///   - _request: The request for which to retrieve the network response.
	///   - retryAuthentification: A boolean value indicating whether to retry authentication if the response status code is 401.
	/// - Returns: The network response, containing a status code and optional data.
	/// - Throws: An error if the network response cannot be retrieved.
	///
	/// This method constructs and sends a URL request based on the provided request parameters. It logs the sending of the request and measures its execution time. If the response status code is in the success range (200-299), it logs the success and returns the response data. If the response status code is 401 (Unauthorized) and retry authentication is enabled, it attempts to refresh the authentication and retries the request. If the response status code is outside the success range and cannot be retried, it logs an error and throws an appropriate network error.
	///
	/// Example usage:
	/// ```swift
	/// do {
	///     let response = try await response(for: request, retryAuthentification: true)
	///     // Use the retrieved network response
	/// } catch {
	///     // Handle error
	/// }
	/// ```
	func response(for _request: RequestProtocol, retryAuthentification: Bool) async throws -> NetworkResponse {
		let url = try self.buildUrl(for: _request)
		
		var request = URLRequest(url: url)
		request.httpMethod = _request.method.rawValue
		request.cachePolicy = .reloadIgnoringLocalCacheData // Allow reponse 304 instead of 200.
		request.timeoutInterval = _request.timeout ?? 60
		
		self.buildHeaders(for: _request).forEach {
			request.setValue($0.value, forHTTPHeaderField: $0.key)
		}
		
		self.buildEncoding(with: _request, in: &request)
		
		Logger.network.debug("\(NetworkLogType.sending.rawValue) - \(_request.description)")
		
		let startDate = Date()
		let session = URLSession(configuration: .default)
		
		let (data, response) = try await session.data(for: request)
		
		let executionTime = Date().timeIntervalSince(startDate)
		let requestId = "\(_request.description) - \(String(format: "%0.3f", executionTime))s"
		
		guard let response = response as? HTTPURLResponse else { throw ResponseError.unknow }
		
		if response.statusCode >= 200 && response.statusCode < 300 {
			if executionTime > _request.warningTime {
				Logger.network.debug("\(NetworkLogType.successWarning.rawValue) - \(requestId)")
			} else {
				Logger.network.debug("\(NetworkLogType.success.rawValue) - \(requestId)")
			}
			
			return (response.statusCode, data)
		}
		
		if response.statusCode == 401 && retryAuthentification {
			var refreshArray: [RequestAuthRefreshableProtocol] = []
			
			if let refreshAuthent = _request.authentification as? RequestAuthRefreshableProtocol {
				refreshArray = [refreshAuthent]
			} else if let authentificationArray = (_request.authentification as? [RequestAuthProtocol])?
				.compactMap({ $0 as? RequestAuthRefreshableProtocol }) {
				refreshArray = authentificationArray
			}
			
			if refreshArray.isEmpty {
				throw self.createNetworkError(request: _request,
											  response: response,
											  data: data)
			}
			
			try await self.refresh(authentification: refreshArray,
								   request: request)
			
			return try await self.response(for: _request, retryAuthentification: false)
		}
		
		throw self.createNetworkError(request: _request,
									  response: response,
									  data: data)
	}
	
	// MARK: - Helpers
	
	/// Creates a network error based on the provided request, response, and data.
	///
	/// - Parameters:
	///   - request: The request associated with the network error.
	///   - response: The HTTP URL response associated with the network error.
	///   - data: The data associated with the network error.
	/// - Returns: The network error.
	///
	/// This method creates a network error of type `.network` using the provided request, response, and data. It logs the error and returns it.
	///
	/// Example usage:
	/// ```swift
	/// let error = createNetworkError(request: request, response: response, data: data)
	/// // Handle the created network error
	/// ```
	private func createNetworkError(request: RequestProtocol,
									response: HTTPURLResponse,
									data: Data?) -> ResponseError {
		let error: ResponseError = .network(response: response, data: data)
		Logger.network.fault("\(NetworkLogType.error.rawValue) - \(request.description) 🛑 \(error.errorDescription ?? "")")
		return error
	}
	
	/// Asynchronously refreshes the authentication for the given request.
	///
	/// - Parameters:
	///   - authentification: An array of objects conforming to the `RequestAuthRefreshableProtocol`, representing the authentication to refresh.
	///   - request: The URL request for which to refresh the authentication.
	/// - Throws: An error if authentication refresh fails.
	///
	/// This method asynchronously refreshes the authentication for the provided request using the first object in the array of refreshable authentication protocols. It then recursively refreshes authentication for the remaining objects in the array. If the array is empty, the method returns without performing any refresh operations.
	///
	/// Example usage:
	/// ```swift
	/// do {
	///     try await refresh(authentification: authArray, request: request)
	///     // Authentication refreshed successfully
	/// } catch {
	///     // Handle authentication refresh error
	/// }
	/// ```
	private func refresh(authentification: [RequestAuthRefreshableProtocol],
						 request: URLRequest) async throws {
		guard let first = authentification.first
		else { return }
		
		try await first.refresh(from: request)
		try await self.refresh(authentification: Array(authentification.dropFirst()),
							   request: request)
	}
}
