//
//  URL+Optional.swift
//
//
//  Created by Thibaud Lambert on 12/05/2024.
//

import Foundation

public extension URL {
	
	/// Initializes an optional `URL` from a string.
	///
	/// - Parameter string: The string from which to create the URL.
	/// - Returns: An optional `URL` if the input string is not `nil` and a valid URL, otherwise `nil`.
	///
	/// This initializer creates an optional `URL` instance from a string. If the input string is not `nil` and represents a valid URL, it returns a new `URL` instance with the same value; otherwise, it returns `nil`.
	///
	/// Example usage:
	/// ```swift
	/// let urlString = "https://www.example.com"
	/// let initializedURL = URL(urlString)
	/// if let url = initializedURL {
	///     print(url) // Prints: "https://www.example.com"
	/// }
	/// ```
	init?(_ string: String?) {
		guard let string = string else { return nil }
		self.init(string: string)
	}
	
}
