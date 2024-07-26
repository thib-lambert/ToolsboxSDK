//
//  GuardedDecodable.swift
//
//
//  Created by Thibaud Lambert on 26/07/2024.
//

import Foundation

/// A property wrapper to safely decode Decodable values, setting them to nil if decoding fails.
@propertyWrapper
public struct GuardedDecodable<T: Decodable>: Decodable {
	
	// MARK: - Variables
	public var wrappedValue: T?
	
	// MARK: - Init
	public init(wrappedValue: T?) {
		self.wrappedValue = wrappedValue
	}
	
	public init(from decoder: Decoder) throws {
		self.wrappedValue = try? T(from: decoder)
	}
}

public extension KeyedDecodingContainer {
	/// Decodes a `GuardedDecodable` value for the specified key, setting it to nil if decoding fails.
	///
	/// - Parameters:
	///   - type: The type of the value to decode.
	///   - key: The key that the decoded value is associated with.
	/// - Returns: A `GuardedDecodable` instance containing the decoded value or nil.
	/// - Throws: An error if the decoding process encounters an error other than the value being absent.
	func decode<T>(_ type: GuardedDecodable<T>.Type,
				   forKey key: Key) throws -> GuardedDecodable<T> {
		try self.decodeIfPresent(type, forKey: key) ?? .init(wrappedValue: nil)
	}
}
