//
//  Collection+Safe.swift
//  
//
//  Created by Thibaud Lambert on 27/04/2024.
//

import Foundation

public extension Collection {
	
	/// Safely accesses the element at the specified index.
	///
	/// - Parameter index: The index of the element to access.
	/// - Returns: The element at the specified index if it exists, or `nil` otherwise.
	///
	/// This subscript returns the element at the specified index, if it is within the bounds of the collection. If the index is out of bounds, `nil` is returned instead of causing a runtime error.
	///
	/// ```swift
	/// let array = [1, 2, 3]
	/// let element = array[safe: 1] // Returns 2
	/// let element = array[safe: 5] // Returns nil
	/// ```
	subscript(safe index: Index) -> Element? {
		indices.contains(index) ? self[index] : nil
	}
}
