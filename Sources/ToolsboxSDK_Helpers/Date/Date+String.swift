//
//  File.swift
//
//
//  Created by Thibaud Lambert on 30/04/2024.
//

import Foundation

public extension Date {
	
	/// Converts the date to a string representation using the specified date and time styles.
	///
	/// - Parameters:
	///   - dateStyle: The style for displaying the date component of the string.
	///   - timeStyle: The style for displaying the time component of the string.
	///   - locale: The locale to use when formatting the date. Default is the current locale.
	/// - Returns: A string representation of the date.
	///
	/// This method creates a `DateFormatter` with the specified date and time styles and locale, then formats the date into a string representation.
	///
	/// Example usage:
	/// ```swift
	/// let currentDate = Date()
	/// let dateString = currentDate.toString(dateStyle: .medium, timeStyle: .short)
	/// print(dateString) // Output: "Apr 27, 2024, 3:51 PM"
	/// ```
	func toString(dateStyle: DateFormatter.Style,
				  timeStyle: DateFormatter.Style,
				  locale: Locale = Locale.current) -> String {
		let formatter = DateFormatter()
		formatter.locale = locale
		formatter.dateStyle = dateStyle
		formatter.timeStyle = timeStyle
		return formatter.string(from: self)
	}
	
	/// Converts the date to a string representation using the specified format.
	///
	/// - Parameters:
	///   - format: The date format string.
	///   - locale: The locale to use when formatting the date. Default is the current locale.
	/// - Returns: A string representation of the date.
	///
	/// This method creates a `DateFormatter` with the specified format and locale, then formats the date into a string representation.
	///
	/// Example usage:
	/// ```swift
	/// let currentDate = Date()
	/// let dateString = currentDate.toString()
	/// print(dateString) // Output: "2024-04-27 15:51:00 +0000"
	/// ```
	func toString(format: String = "yyyy-MM-dd'T'HH:mm:ssZ",
				  locale: Locale = Locale.current) -> String {
		let formatter = DateFormatter()
		formatter.locale = locale
		formatter.dateFormat = format
		return formatter.string(from: self)
	}
}
