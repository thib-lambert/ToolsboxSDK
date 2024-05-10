//
//  Sequence+Group.swift
//
//
//  Created by Thibaud Lambert on 10/05/2024.
//

import Foundation

public extension Sequence {
	
	/// Groups the elements of the sequence based on a key.
	///
	/// - Parameter key: A closure that returns the key for each element in the sequence.
	/// - Returns: A dictionary where the keys are the result of applying the key closure to the elements, and the values are arrays of elements grouped by the key.
	///
	/// This method groups the elements of the sequence into a dictionary where the keys are determined by applying the given key closure to each element. The values associated with each key are arrays containing all elements that have the same key.
	///
	/// Example usage:
	/// ```swift
	/// let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	/// let groupedNumbers = numbers.group(by: { $0 % 2 == 0 ? "Even" : "Odd" })
	/// print(groupedNumbers)
	/// // Output: ["Even": [2, 4, 6, 8, 10], "Odd": [1, 3, 5, 7, 9]]
	/// ```
	func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U: [Iterator.Element]] {
		self.reduce(into: [U: [Iterator.Element]]()) { partialResult, element in
			let key: U = key(element)
			
			if let values = partialResult[key] {
				partialResult[key]?.append(element)
			} else {
				partialResult[key] = [element]
			}
		}
	}
}
