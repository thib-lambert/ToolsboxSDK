//
//  Decodable+Decode.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation
import os
import Common

public extension Decodable {
	
	static func decode(from data: Any?) throws -> Self {
		guard let data,
			  let jsonData = (data as? Data) ?? (try? JSONSerialization.data(withJSONObject: data))
		else {
			throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [],
																	debugDescription: "Empty data"))
		}
		
		do {
			return try JSONDecoder().decode(Self.self, from: jsonData)
		} catch DecodingError.keyNotFound(let key, let context) {
			Logger.data.fault("Key \"\(key.stringValue)\" not found in \(String(describing: Self.self))")
			throw DecodingError.keyNotFound(key, context)
		} catch DecodingError.valueNotFound(let type, let context) {
			Logger.data.fault("Type \"\(type)\" not found in \(String(describing: Self.self))")
			throw DecodingError.valueNotFound(type, context)
		} catch DecodingError.typeMismatch(let type, let context) {
			Logger.data.fault("\"\(type)\" not match in \(String(describing: Self.self))")
			throw DecodingError.typeMismatch(type, context)
		} catch DecodingError.dataCorrupted(let context) {
			Logger.data.fault("Data corruped in \(String(describing: Self.self))")
			throw DecodingError.dataCorrupted(context)
		}
	}
}
