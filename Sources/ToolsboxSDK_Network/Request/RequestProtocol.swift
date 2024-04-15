//
//  RequestProtocol.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation
import os

public protocol RequestProtocol: CustomStringConvertible {
	
	var scheme: String { get }
	var host: String { get }
	var path: String { get }
	var port: Int? { get }
	var warningTime: TimeInterval { get }
	var timeout: TimeInterval? { get }
	var method: RequestMethodType { get }
	var headers: RequestHeaders? { get }
	var cacheKey: RequestCacheKey? { get }
	var encoding: RequestParamatersEncodingType { get }
	var parameters: RequestParameters? { get }
	var authentification: RequestAuthProtocol? { get }
	var retryAuthentification: Bool { get }
}

// MARK: - Default values
extension RequestProtocol {
	
	var description: String {
		"\(self.method.rawValue) - \(self.scheme)://\(self.host)\(self.path)"
	}
	
	var port: Int? { nil }
	var warningTime: TimeInterval { 2 }
	var timeout: TimeInterval? { nil }
	var headers: RequestHeaders? { nil }
	var cacheKey: RequestCacheKey? { nil }
	var encoding: RequestParamatersEncodingType { .url }
	var parameters: RequestParameters? { nil }
	var authentification: RequestAuthProtocol? { nil }
	var retryAuthentification: Bool { true }
}

// MARK: - Cache
public extension RequestProtocol {
	
	func clearCache() {
		guard let cacheKey else { return }
		NetworkCache.shared.delete(cacheKey)
	}
}
