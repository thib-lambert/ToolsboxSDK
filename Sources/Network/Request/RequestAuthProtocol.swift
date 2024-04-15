//
//  RequestAuthProtocol.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

public protocol RequestAuthProtocol {
	
	var headers: RequestHeaders { get }
	var bodyParameters: RequestParameters { get }
	var urlQueryItems: [URLQueryItem] { get }
}

extension RequestAuthProtocol {
	
	var headers: RequestHeaders { [:] }
	var bodyParameters: RequestParameters { [:] }
	var urlQueryItems: [URLQueryItem] { [] }
}

extension Array: RequestAuthProtocol where Element == RequestAuthProtocol {
	
	public var headers: RequestHeaders {
		self.reduce(into: [:]) { headers, new in
			let value: RequestHeaders = new.headers
			headers = headers.merging(value) { current, _ in current }
		}
	}
	
	public var bodyParameters: RequestParameters {
		self.reduce(into: [:]) { params, new in
			let value: RequestParameters = new.bodyParameters
			params = params.merging(value) { current, _ in current }
		}
	}
	
	public var urlQueryItems: [URLQueryItem] {
		self.flatMap { $0.urlQueryItems }
	}
}
