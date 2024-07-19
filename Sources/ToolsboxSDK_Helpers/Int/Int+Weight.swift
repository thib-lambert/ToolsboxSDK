//
//  Int+Weight.swift
//
//
//  Created by Thibaud Lambert on 19/07/2024.
//

import Foundation

public extension Int {
	
	/// Converts a weight value in kilograms to a formatted string based on the provided parameters.
	///
	/// - Parameters:
	///   - minimumFractionDigits: The minimum number of fractional digits to display. Default is 0.
	///   - maximumFractionDigits: The maximum number of fractional digits to display. Default is 0.
	///   - locale: The locale to use for formatting. Default is the current locale.
	/// - Returns: A formatted string representing the weight.
	func toWeight(minimumFractionDigits: Int = 0,
				  maximumFractionDigits: Int = 0,
				  locale: Locale = Locale.current) -> String {
		Double(self).toWeight(minimumFractionDigits: minimumFractionDigits,
							  maximumFractionDigits: maximumFractionDigits,
							  locale: locale)
	}
}
