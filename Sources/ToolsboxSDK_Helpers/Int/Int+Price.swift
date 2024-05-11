//
//  Int+Price.swift
//
//
//  Created by Thibaud Lambert on 11/05/2024.
//

import Foundation

public extension Int {
	
	/// Formats the floating-point number as a price string.
	///
	/// - Parameters:
	///   - currency: The currency symbol to display.
	///   - currencyCode: The currency code to use for formatting.
	///   - minimumFractionDigits: The minimum number of fractional digits to display.
	///   - maximumFractionDigits: The maximum number of fractional digits to display.
	/// - Returns: The formatted price string.
	///
	/// This method converts the floating-point number to a price string using the provided currency symbol or code and formatting options.
	///
	/// Example usage:
	/// ```swift
	/// let priceString = someDouble.toPrice(currency: "$", minimumFractionDigits: 2)
	/// // Use the formatted price string
	/// ```
	func toPrice(currency: String? = nil,
				 currencyCode: String? = nil,
				 minimumFractionDigits: Int = 2,
				 maximumFractionDigits: Int = 2) -> String {
		Double(self).toPrice(currency: currency,
							 currencyCode: currencyCode,
							 minimumFractionDigits: minimumFractionDigits,
							 maximumFractionDigits: maximumFractionDigits)
	}
}
