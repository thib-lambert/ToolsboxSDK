//
//  RequestProtocol.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

/// Protocol defining the properties and behavior of a network request.
public protocol RequestProtocol: CustomStringConvertible {
	
	/// The URL scheme (e.g., "http" or "https") for the request.
	var scheme: String { get }
	
	/// The host component of the URL for the request.
	var host: String { get }
	
	/// The path component of the URL for the request.
	var path: String { get }
	
	/// The port number to use for the request, if any.
	var port: Int? { get }
	
	/// The warning time interval for the request, used for monitoring purposes.
	var warningTime: TimeInterval { get }
	
	/// The timeout interval for the request, if any.
	var timeout: TimeInterval? { get }
	
	/// The HTTP request method type.
	var method: RequestMethodType { get }
	
	/// The headers to include in the request.
	var headers: RequestHeaders? { get }
	
	/// The cache key for caching the response of the request, if any.
	var cacheKey: RequestCacheKey? { get }
	
	/// The encoding type for request parameters.
	var encoding: RequestParamatersEncodingType { get }
	
	/// The parameters to include in the request, if any.
	var parameters: RequestParameters? { get }
	
	/// The authentication details for the request, if any.
	var authentification: RequestAuthProtocol? { get }
	
	/// A flag indicating whether to retry authentication if it fails initially.
	var retryAuthentification: Bool { get }
}

// MARK: - Default values
extension RequestProtocol {
	
	/// A textual representation of the request.
	var description: String {
		"\(self.method.rawValue) - \(self.scheme)://\(self.host)\(self.path)"
	}
	
	/// The default port number for the request.
	var port: Int? { nil }
	
	/// The default warning time interval for the request.
	var warningTime: TimeInterval { 2 }
	
	/// The default timeout interval for the request.
	var timeout: TimeInterval? { nil }
	
	/// The default headers for the request.
	var headers: RequestHeaders? { nil }
	
	/// The default cache key for the request.
	var cacheKey: RequestCacheKey? { nil }
	
	/// The default encoding type for request parameters.
	var encoding: RequestParamatersEncodingType { .url }
	
	/// The default parameters for the request.
	var parameters: RequestParameters? { nil }
	
	/// The default authentication details for the request.
	var authentification: RequestAuthProtocol? { nil }
	
	/// The default value indicating whether to retry authentication.
	var retryAuthentification: Bool { true }
}

// MARK: - Cache
public extension RequestProtocol {
	
	/// Clears the cache for the request, if a cache key is provided.
	func clearCache() {
		guard let cacheKey else { return }
		NetworkCache.shared.delete(cacheKey)
	}
}
