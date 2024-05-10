//
//  Encodable+JSON.swift
//
//
//  Created by Thibaud Lambert on 28/04/2024.
//

import Foundation

public extension Encodable {
	
	/// Converts the conforming instance to a JSON dictionary.
	///
	/// - Parameter cleanNilValues: A boolean value indicating whether to clean nil values from the resulting JSON dictionary. Default is `false`.
	/// - Returns: A JSON dictionary representing the conforming instance.
	///
	/// This method encodes the conforming instance using `JSONEncoder` and then converts the encoded data into a JSON dictionary using `JSONSerialization`. If `cleanNilValues` is set to `true`, it removes any key-value pairs where the value is `NSNull`. The resulting JSON dictionary is returned.
	///
	/// Example usage:
	/// ```swift
	/// struct MyStruct: Encodable {
	///     let name: String
	///     let age: Int?
	/// }
	///
	/// let myInstance = MyStruct(name: "John", age: nil)
	/// let json = myInstance.toJson(cleanNilValues: true)
	/// print(json) // Output: ["name": "John"]
	/// ```
	func toJson(cleanNilValues: Bool = false) -> [String: AnyObject] {
		guard let data = try? JSONEncoder().encode(self),
			  let object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: AnyObject]
		else {
			return [:]
		}
		
		if cleanNilValues {
			return object.filter { !($0.value is NSNull) }
		}
		
		return object
	}
}
