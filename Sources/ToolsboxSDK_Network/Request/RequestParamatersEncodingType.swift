//
//  RequestParamatersEncodingType.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

/// Enum representing various types of request parameters encoding.
public enum RequestParamatersEncodingType {
	
	/// Represents JSON encoding for request parameters.
	case json
	
	/// Represents URL encoding for request parameters.
	case url
	
	/// Represents x-www-form-urlencoded encoding for request parameters.
	case formURLEncoded
	
	/// Represents custom encoding for request parameters.
	case custom(encode: String, body: Data?)
}
