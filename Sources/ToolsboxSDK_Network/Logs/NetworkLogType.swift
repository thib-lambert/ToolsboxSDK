//
//  NetworkLogType.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

enum NetworkLogType: String {
	
	/// Indicates a log message for sending data.
	case sending
	
	/// Indicates a successful network operation.
	case success
	
	/// Indicates a successful network operation with a warning.
	case successWarning
	
	/// Indicates a log message related to cached data.
	case cache
	
	/// Indicates an error in a network operation.
	case error
	
	/// The prefix associated with each log type.
	var prefix: String {
		switch self {
		case .sending: return "➡️"
		case .success: return "✅"
		case .successWarning: return "✅⚠️"
		case .cache: return "✅🗄"
		case .error: return "❌"
		}
	}
}

