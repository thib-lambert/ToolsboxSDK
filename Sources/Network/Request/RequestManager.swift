//
//  RequestManager.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation
import os
import Common

public typealias RequestHeaders = [String: String]
public typealias NetworkResponse = (statusCode: Int, data: Data?)
public typealias RequestParameters = [String: Any]
typealias ParametersArray = [(key: String, value: Any)]

class RequestManager {
	
	// MARK: - Singleton
	static let shared = RequestManager()
	
	// MARK: - Init
	private init() { }
	
	// MARK: - Build
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
	
	private func buildHeaders(for request: RequestProtocol) -> RequestHeaders {
		var finalHeaders: RequestHeaders = request.authentification?.headers ?? [:]
		
		// Headers
		request.headers?.forEach {
			finalHeaders[$0.key] = $0.value
		}
		
		return finalHeaders
	}
	
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
					Logger.network.fault("\(RequestError.url): \(error)")
				}
			} else {
				Logger.network.fault("\(RequestError.url)")
			}
		}
		
		return nil
	}
	
	// MARK: - Response
	func response(for _request: RequestProtocol, retryAuthentification: Bool) async throws -> NetworkResponse {
		let url = try self.buildUrl(for: _request)
		
		var request = URLRequest(url: url)
		request.httpMethod = _request.method.rawValue
		request.cachePolicy = .reloadIgnoringLocalCacheData // Allow reponse 304 instead of 200.
		request.timeoutInterval = _request.timeout ?? 60
		
		self.buildHeaders(for: _request).forEach {
			request.setValue($0.value, forHTTPHeaderField: $0.key)
		}
		
		switch _request.encoding {
		case .json:
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.httpBody = self.buildJSONBodyData(for: _request)
			
		default:
			break
		}
		
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
	private func createNetworkError(request: RequestProtocol,
									response: HTTPURLResponse,
									data: Data?) -> ResponseError {
		let error: ResponseError = .network(response: response, data: data)
		Logger.network.fault("\(NetworkLogType.error.rawValue) - \(request.description) 🛑 \(error.errorDescription ?? "")")
		return error
	}
	
	private func refresh(authentification: [RequestAuthRefreshableProtocol],
						 request: URLRequest) async throws {
		guard let first = authentification.first
		else { return }
		
		try await first.refresh(from: request)
		try await self.refresh(authentification: Array(authentification.dropFirst()),
							   request: request)
	}
}
