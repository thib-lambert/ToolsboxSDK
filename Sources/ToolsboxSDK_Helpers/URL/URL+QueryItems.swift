//
//  URL+QueryItems.swift
//
//
//  Created by Thibaud Lambert on 10/05/2024.
//

import Foundation

public extension URL {
	
	/// Extracts the query items from the URL.
	///
	/// - Returns: A dictionary containing the query items.
	///
	/// This method parses the query items from the URL and returns them as a dictionary of key-value pairs. If the URL does not contain any query items, an empty dictionary is returned.
	///
	/// Example usage:
	/// ```swift
	/// let url = URL(string: "https://www.example.com?param1=value1&param2=value2")!
	/// let queryItems = url.getQueryItems()
	/// print(queryItems) // Output: ["param1": "value1", "param2": "value2"]
	/// ```
	func getQueryItems() -> [String: String] {
		guard let items = URLComponents(string: self.absoluteString)?.queryItems
		else { return [:] }
		
		return items.reduce(into: [String: String]()) { partialResult, item in
			partialResult[item.name] = item.value
		}
	}
}
