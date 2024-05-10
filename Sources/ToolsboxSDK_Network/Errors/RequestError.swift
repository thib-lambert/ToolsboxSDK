//
//  File.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

enum RequestError: LocalizedError {
	
	/// Error case indicating an invalid URL.
	case url
	
	/// Error case indicating invalid JSON data.
	case json
	
	/// Error case indicating an empty cache.
	case emptyCache
	
	/// A localized description of the error.
	var errorDescription: String? {
		switch self {
		case .url: return "Invalid URL!"
		case .json: return "Invalid JSON!"
		case .emptyCache: return "Empty cache!"
		}
	}
}
