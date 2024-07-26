//
//  GuardedCodable.swift
//
//
//  Created by Thibaud Lambert on 26/07/2024.
//

import Foundation

/// A property wrapper to safely decode Codable values, setting them to nil if decoding fails.
@propertyWrapper
public struct GuardedCodable<T: Codable>: Codable {
	
	// MARK: - Variables
	public var wrappedValue: T?
	
	// MARK: - Init
	public init(wrappedValue: T?) {
		self.wrappedValue = wrappedValue
	}
	
	public init(from decoder: Decoder) throws {
		self.wrappedValue = try? T(from: decoder)
	}
	
	// MARK: - Encode
	public func encode(to encoder: Encoder) throws {
		try self.wrappedValue.encode(to: encoder)
	}
}

public extension KeyedDecodingContainer {
	
	/// Decodes a `GuardedCodable` value for the specified key, setting it to nil if decoding fails.
	///
	/// - Parameters:
	///   - type: The type of the value to decode.
	///   - key: The key that the decoded value is associated with.
	/// - Returns: A `GuardedCodable` instance containing the decoded value or nil.
	/// - Throws: An error if the decoding process encounters an error other than the value being absent.
	func decode<T>(_ type: GuardedCodable<T>.Type,
						  forKey key: Key) throws -> GuardedCodable<T> {
		try self.decodeIfPresent(type, forKey: key) ?? .init(wrappedValue: nil)
	}
}
