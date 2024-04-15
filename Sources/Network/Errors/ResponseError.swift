//
//  File.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

enum ResponseError: LocalizedError {
	
	case data,
		 unknow
	case network(response: HTTPURLResponse?, data: Data?)
	
	var errorDescription: String? {
		switch self {
		case .data:
			return "Data error"
			
		case .unknow:
			return "Response error"
			
		case .network(let response, _):
			guard let statusCode = response?.statusCode else { return "Unkown Error" }
			return "\(statusCode): \(HTTPURLResponse.localizedString(forStatusCode: statusCode))"
		}
	}
}
