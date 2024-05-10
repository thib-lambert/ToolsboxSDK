//
//  RequestMethodType.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

/// Enum representing various HTTP request method types.
public enum RequestMethodType: String {
	
	/// Represents the DELETE HTTP request method.
	case delete = "DELETE"
	
	/// Represents the GET HTTP request method.
	case get = "GET"
	
	/// Represents the PATCH HTTP request method.
	case patch = "PATCH"
	
	/// Represents the POST HTTP request method.
	case post = "POST"
	
	/// Represents the PUT HTTP request method.
	case put = "PUT"
}
