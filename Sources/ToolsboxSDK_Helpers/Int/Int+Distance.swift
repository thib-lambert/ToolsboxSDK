//
//  Int+Distance.swift
//
//
//  Created by Thibaud Lambert on 01/06/2024.
//

import Foundation

public extension Int {
	
	/// Converts the `Double` value to a localized distance string representation.
	///
	/// - Parameters:
	///   - minimumFractionDigits: The minimum number of fractional digits to display. Default is 0.
	///   - maximumFractionDigits: The maximum number of fractional digits to display. Default is 0.
	///   - locale: The locale to use for formatting. Default is the current locale.
	/// - Returns: A string representation of the distance.
	///
	/// This method formats the `Int` value as a distance using the provided locale and fraction digit settings.
	///
	/// Example usage:
	/// ```swift
	/// let usLocale = Locale(identifier: "en_US")
	/// let formattedDistanceUS = distance.toDistance(minimumFractionDigits: 2, maximumFractionDigits: 2, locale: usLocale)
	/// print(formattedDistanceUS) // "1.23 km" ou "0.77 mi"
	///
	/// let frLocale = Locale(identifier: "fr_FR")
	/// let formattedDistanceFR = distance.toDistance(minimumFractionDigits: 0, maximumFractionDigits: 1, locale: frLocale)
	/// print(formattedDistanceFR) // "1,2 km"
	/// ```
	func toDistance(minimumFractionDigits: Int = 0,
					maximumFractionDigits: Int = 0,
					locale: Locale = Locale.current) -> String {
		Double(self).toDistance(minimumFractionDigits: minimumFractionDigits,
								maximumFractionDigits: maximumFractionDigits,
								locale: locale)
	}
}
