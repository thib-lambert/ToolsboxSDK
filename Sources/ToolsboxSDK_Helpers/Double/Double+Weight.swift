//
//  Double+Weight.swift
//
//
//  Created by Thibaud Lambert on 19/07/2024.
//

import Foundation

public extension Double {
	
	/// Converts a weight value in kilograms to a formatted string based on the provided parameters.
	///
	/// - Parameters:
	///   - minimumFractionDigits: The minimum number of fractional digits to display. Default is 2.
	///   - maximumFractionDigits: The maximum number of fractional digits to display. Default is 2.
	/// - Returns: A formatted string representing the weight.
	func toWeight(minimumFractionDigits: Int = 2,
				  maximumFractionDigits: Int = 2) -> String {
		let numberFormatter = NumberFormatter()
		numberFormatter.minimumFractionDigits = minimumFractionDigits
		numberFormatter.maximumFractionDigits = minimumFractionDigits > maximumFractionDigits
		? minimumFractionDigits
		: maximumFractionDigits
		
		let formatter = MassFormatter()
		formatter.unitStyle = .short
		formatter.numberFormatter = numberFormatter
		
		return formatter.string(fromValue: self, unit: .kilogram)
	}
}
