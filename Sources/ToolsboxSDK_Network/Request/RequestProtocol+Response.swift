//
//  RequestProtocol+Response.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation
import os
import ToolsboxSDK_Core

public extension RequestProtocol {
	
	/// Asynchronously retrieves the network response for the request.
	///
	/// - Returns: A tuple containing the status code and data of the network response.
	/// - Throws: An error if the network response cannot be retrieved.
	///
	/// This method first checks if there is cached data available based on the provided cache key. If cache data is available and the cache policy allows, it returns the cached data. If cache data is required but not available, an empty cache error is thrown. If no cached data is required or available, the request is sent to the network. Upon receiving the network response, it updates the cache if necessary and returns the response data.
	///
	/// Example usage:
	/// ```swift
	/// do {
	///     let response = try await request.response()
	///     // Process network response
	/// } catch {
	///     // Handle error
	/// }
	/// ```
	internal func response() async throws -> NetworkResponse {
		if let cacheKey {
			switch cacheKey.type {
			case .returnCacheDataElseLoad:
				if let data = NetworkCache.shared.get(cacheKey) {
					Logger.network.debug("\(NetworkLogType.cache.rawValue) - \(self) with key \(cacheKey.key)")
					return (statusCode: 200, data: data)
				}
				
			case .returnCacheDataDontLoad:
				if let data = NetworkCache.shared.get(cacheKey) {
					Logger.network.debug("\(NetworkLogType.cache.rawValue) - \(self) with key \(cacheKey.key)")
					return (statusCode: 200, data: data)
				}
				
				let error: RequestError = .emptyCache
				Logger.network.fault("\(NetworkLogType.cache.rawValue) - \(self) with key \(cacheKey.key) with error \(error)")
				throw error
			}
		}
		
		do {
			let response = try await RequestManager.shared.response(for: self,
																	retryAuthentification: self.retryAuthentification)
			
			if let cacheKey {
				NetworkCache.shared.set(response.data, for: cacheKey)
			}
			
			return response
		} catch {
			if let cacheKey,
			   let data = NetworkCache.shared.get(cacheKey) {
				Logger.network.debug("\(NetworkLogType.cache.rawValue) \(self) with key \(cacheKey.key)")
				return (statusCode: 200, data: data)
			}
			
			throw error
		}
	}
	
	/// Asynchronously retrieves and decodes the network response for the request.
	///
	/// - Parameter type: The type to decode the response into.
	/// - Returns: The decoded response of the specified type.
	/// - Throws: An error if the network response cannot be retrieved or decoded.
	///
	/// This method asynchronously retrieves the network response using the `response()` method and decodes it into the specified type using the `decode(from:)` method. If decoding fails, an error is thrown.
	///
	/// Example usage:
	/// ```swift
	/// do {
	///     let decodedResponse: MyModel = try await request.response(MyModel.self)
	///     // Process decoded response
	/// } catch {
	///     // Handle error
	/// }
	/// ```
	func response<T: Decodable>(_ type: T.Type) async throws -> T {
		let response = try await self.response()
		
		guard let data = response.data
		else { throw ResponseError.data }
		
		do {
			return try T.decode(from: data)
		} catch {
			Logger.network.fault("\(NetworkLogType.error.rawValue) \(error.localizedDescription)")
			throw error
		}
	}
	
	/// Asynchronously sends the request and discards the response.
	///
	/// - Throws: An error if the request cannot be sent or if the response cannot be retrieved.
	///
	/// This method asynchronously sends the request using the `response()` method and discards the response. It can be used for fire-and-forget scenarios where only the act of sending the request matters.
	///
	/// Example usage:
	/// ```swift
	/// do {
	///     try await request.send()
	///     // Request sent successfully
	/// } catch {
	///     // Handle error
	/// }
	/// ```
	func send() async throws {
		_ = try await self.response()
	}
}
