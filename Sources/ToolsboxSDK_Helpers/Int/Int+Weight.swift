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
	/// - Returns: A formatted string representing the weight.
	func toWeight() -> String {
		Double(self).toWeight(minimumFractionDigits: 0,
							  maximumFractionDigits: 0)
	}
}
