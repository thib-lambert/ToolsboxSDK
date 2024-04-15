//
//  File.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

enum RequestError: LocalizedError {
	
	case url,
		 json,
		 emptyCache
	
	var errorDescription: String? {
		switch self {
		case .url: return "Invalid URL !"
		case .json: return "Invalid JSON !"
		case .emptyCache: return "Empty cache !"
		}
	}
}
