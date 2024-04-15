//
//  NetworkLogType.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

enum NetworkLogType: String {
	
	case sending
	case success
	case successWarning
	case error
	case cache
	
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
