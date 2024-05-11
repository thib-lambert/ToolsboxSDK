//
//  Double+Price.swift
//
//
//  Created by Thibaud Lambert on 11/05/2024.
//

import Foundation

public extension Double {
	
	/// Indicates whether the floating-point number is a decimal.
	///
	/// This computed property returns `true` if the floating-point number is a decimal (i.e., has a fractional part), and `false` otherwise.
	///
	/// Example usage:
	/// ```swift
	/// let isDecimal = someDouble.isDecimal
	/// // Use the result to determine if the double is a decimal
	/// ```
	private var isDecimal: Bool {
		Double(Int(self)) != self
	}
	
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
