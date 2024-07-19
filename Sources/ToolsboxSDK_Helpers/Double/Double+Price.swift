//
//  Double+Price.swift
//
//
//  Created by Thibaud Lambert on 11/05/2024.
//

import Foundation

public extension Double {
	
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
		let numberFormatter = NumberFormatter()
		numberFormatter.minimumFractionDigits = self.isDecimal ? minimumFractionDigits : 0
		numberFormatter.maximumFractionDigits = maximumFractionDigits
		
		if let currency {
			numberFormatter.numberStyle = .decimal
			
			// swiftlint:disable:next legacy_objc_type
			if let price = numberFormatter.string(from: NSNumber(value: self)) {
				return "\(price) \(currency)"
			}
		}
		
		if let currencyCode {
			// swiftlint:disable:next legacy_objc_type
			let _currency = NSLocale(localeIdentifier: currencyCode)
				.displayName(forKey: .currencySymbol, value: currencyCode) ?? currency
			
			return self.toPrice(currency: _currency,
								minimumFractionDigits: minimumFractionDigits,
								maximumFractionDigits: maximumFractionDigits)
		}
		
		numberFormatter.numberStyle = .currency
		
		// swiftlint:disable:next legacy_objc_type
		return numberFormatter.string(from: NSNumber(value: self)) ?? ""
	}
}
