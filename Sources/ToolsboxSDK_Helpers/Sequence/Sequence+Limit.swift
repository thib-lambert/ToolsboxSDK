//
//  Sequence+Limit.swift
//
//
//  Created by Thibaud Lambert on 10/05/2024.
//

import Foundation

public extension Sequence {
	
	/// Limits the number of elements in the sequence.
	///
	/// - Parameter limit: The maximum number of elements to include in the result.
	/// - Returns: An array containing the first `limit` elements of the sequence.
	///
	/// This method returns an array containing the first `limit` elements of the sequence. If the sequence contains fewer than `limit` elements, all elements are included in the result.
	///
	/// Example usage:
	/// ```swift
	/// let numbers = [1, 2, 3, 4, 5]
	/// let limitedNumbers = numbers.limit(3)
	/// print(limitedNumbers) // Output: [1, 2, 3]
	/// ```
	func limit(_ limit: Int) -> [Element] {
		Array(self.prefix(limit))
	}
}
