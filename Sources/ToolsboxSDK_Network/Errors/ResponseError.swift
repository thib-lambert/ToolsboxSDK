//
//  File.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

/// Enum representing various response errors.
enum ResponseError: LocalizedError {
	
	/// Error case indicating a data error.
	case data
	
	/// Error case indicating an unknown error in the response.
	case unknow
	
	/// Error case indicating a network-related error in the response.
	case network(response: HTTPURLResponse?, data: Data?)
	
	/// A localized description of the error.
	var errorDescription: String? {
		switch self {
		case .data:
			return "Data error"
			
		case .unknow:
			return "Response error"
			
		case .network(let response, _):
			guard let statusCode = response?.statusCode else { return "Unknown Error" }
			return "\(statusCode): \(HTTPURLResponse.localizedString(forStatusCode: statusCode))"
		}
	}
}
