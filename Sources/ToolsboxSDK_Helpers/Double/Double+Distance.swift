//
//  Double+Distance.swift
//
//
//  Created by Thibaud Lambert on 01/06/2024.
//

import Foundation

public extension Double {
	
	/// Converts the `Double` value to a localized distance string representation.
	///
	/// - Parameters:
	///   - minimumFractionDigits: The minimum number of fractional digits to display. Default is 2.
	///   - maximumFractionDigits: The maximum number of fractional digits to display. Default is 2.
	/// - Returns: A string representation of the distance.
	///
	/// This method formats the `Double` value as a distance using the provided locale and fraction digit settings.
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
	func toDistance(minimumFractionDigits: Int = 2,
					maximumFractionDigits: Int = 2,
					locale: Locale = Locale.current) -> String {
		let numberFormatter = NumberFormatter()
		numberFormatter.minimumFractionDigits = minimumFractionDigits
		numberFormatter.maximumFractionDigits = minimumFractionDigits > maximumFractionDigits
		? minimumFractionDigits
		: maximumFractionDigits
		
		let formatter = MeasurementFormatter()
		formatter.locale = locale
		formatter.numberFormatter = numberFormatter
		formatter.unitOptions = .naturalScale
		
		return formatter.string(from: Measurement(value: self, unit: UnitLength.meters))
	}
}
