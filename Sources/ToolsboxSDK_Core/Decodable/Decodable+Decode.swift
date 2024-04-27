//
//  Decodable+Decode.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation
import os

/// An extension to provide decoding functionality for types conforming to `Decodable`.
public extension Decodable {
	
	/// Decodes an instance of the conforming type from the given data.
	///
	/// - Parameter data: The data to decode. This can be either `Data` or a JSON-compatible object that can be converted to `Data`.
	/// - Returns: An instance of the conforming type, decoded from the provided data.
	/// - Throws: An error if decoding fails, including `DecodingError.dataCorrupted` if the data is empty, or other decoding errors such as `keyNotFound`, `valueNotFound`, `typeMismatch`, or `dataCorrupted`.
	///
	/// This method provides a convenient way to decode an instance of a `Decodable` type from data, whether it's in `Data` format or a JSON-compatible object. It utilizes `JSONDecoder` for decoding. If decoding fails, detailed error information is logged using the `Logger` and the corresponding `DecodingError` is thrown.
	///
	/// Example usage:
	/// ```swift
	/// struct MyStruct: Decodable {
	///     let name: String
	///     let age: Int
	/// }
	///
	/// let jsonString = "{\"name\": \"John\", \"age\": 30}"
	/// let data = jsonString.data(using: .utf8)
	///
	/// do {
	///     let myStruct = try MyStruct.decode(from: data)
	///     print(myStruct)
	/// } catch {
	///     print("Error decoding: \(error)")
	/// }
	/// ```
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
