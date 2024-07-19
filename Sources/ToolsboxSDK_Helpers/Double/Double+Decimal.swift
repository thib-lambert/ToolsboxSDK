//
//  Double+Decimal.swift
//
//
//  Created by Thibaud Lambert on 19/07/2024.
//

import Foundation

extension Double {
	
	/// Indicates whether the floating-point number is a decimal.
	///
	/// This computed property returns `true` if the floating-point number is a decimal (i.e., has a fractional part), and `false` otherwise.
	///
	/// Example usage:
	/// ```swift
	/// let isDecimal = someDouble.isDecimal
	/// // Use the result to determine if the double is a decimal
	/// ```
	var isDecimal: Bool {
		Double(Int(self)) != self
	}
}
