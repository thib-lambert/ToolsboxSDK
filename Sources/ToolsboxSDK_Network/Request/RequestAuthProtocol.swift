//
//  RequestAuthProtocol.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

/// Protocol defining the authentication details required for a request.
public protocol RequestAuthProtocol {
	
	/// The headers to be included in the request.
	var headers: RequestHeaders { get }
	
	/// The body parameters to be included in the request.
	var bodyParameters: RequestParameters { get }
	
	/// The URL query items to be included in the request.
	var urlQueryItems: [URLQueryItem] { get }
}

extension RequestAuthProtocol {
	
	/// Default implementation for headers.
	var headers: RequestHeaders { [:] }
	
	/// Default implementation for body parameters.
	var bodyParameters: RequestParameters { [:] }
	
	/// Default implementation for URL query items.
	var urlQueryItems: [URLQueryItem] { [] }
}

extension Array: RequestAuthProtocol where Element == RequestAuthProtocol {
	
	/// Merges the headers of all elements in the array.
	public var headers: RequestHeaders {
		self.reduce(into: [:]) { headers, new in
			let value: RequestHeaders = new.headers
			headers = headers.merging(value) { current, _ in current }
		}
	}
	
	/// Merges the body parameters of all elements in the array.
	public var bodyParameters: RequestParameters {
		self.reduce(into: [:]) { params, new in
			let value: RequestParameters = new.bodyParameters
			params = params.merging(value) { current, _ in current }
		}
	}
	
	/// Combines the URL query items of all elements in the array.
	public var urlQueryItems: [URLQueryItem] {
		self.flatMap { $0.urlQueryItems }
	}
}

