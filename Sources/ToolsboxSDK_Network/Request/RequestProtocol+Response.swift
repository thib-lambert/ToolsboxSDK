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
	
	func response() async throws -> NetworkResponse {
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
	
	func send() async throws {
		_ = try await self.response()
	}
}
