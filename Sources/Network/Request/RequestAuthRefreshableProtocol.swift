//
//  RequestAuthRefreshableProtocol.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

public protocol RequestAuthRefreshableProtocol: RequestAuthProtocol {
	
	func refresh(from request: URLRequest) async throws
}
