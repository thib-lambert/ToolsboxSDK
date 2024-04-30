//
//  File.swift
//
//
//  Created by Thibaud Lambert on 30/04/2024.
//

import Foundation

/// An extension to provide date conversion functionality for `String` instances.
public extension String {
	
	/// Converts the string to a `Date` instance using the specified date format.
	///
	/// - Parameters:
	///   - format: The date format string. Default is "yyyy-MM-dd'T'HH:mm:ssZ".
	///   - locale: The locale to use when parsing the date. Default is the current locale.
	/// - Returns: A `Date` instance representing the parsed date, or `nil` if parsing fails.
	///
	/// This method creates a `DateFormatter` with the specified format and locale, then attempts to parse the string into a `Date` instance. If parsing is successful, the `Date` instance is returned; otherwise, `nil` is returned.
	///
	/// Example usage:
	/// ```swift
	/// let dateString = "2024-04-27T15:51:00+0000"
	/// if let date = dateString.toDate() {
	///     print(date) // Output: "2024-04-27 15:51:00 +0000"
	/// }
	/// ```
	func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZ",
				locale: Locale = Locale.current) -> Date? {
		let formatter = DateFormatter()
		formatter.locale = locale
		formatter.dateFormat = format
		return formatter.date(from: self)
	}
}
