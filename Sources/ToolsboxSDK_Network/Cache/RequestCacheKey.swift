//
//  RequestCacheKey.swift
//
//
//  Created by Thibaud Lambert on 10/05/2024.
//

import Foundation

/// Struct representing a cache key for network requests.
public struct RequestCacheKey {
	
	/// The key used to identify the cache entry.
	let key: String
	
	/// The date until which the cached data is considered valid.
	let availableDate: Date
	
	/// The type of network cache behavior associated with the key.
	let type: NetworkCacheType
	
	/// Initializes a cache key with the provided parameters.
	///
	/// - Parameters:
	///   - key: The key used to identify the cache entry.
	///   - type: The type of network cache behavior associated with the key.
	///   - days: The number of days to add to the current date for determining the expiration date of the cache entry. Default is `nil`.
	///   - hours: The number of hours to add to the current date for determining the expiration date of the cache entry. Default is `nil`.
	///   - minutes: The number of minutes to add to the current date for determining the expiration date of the cache entry. Default is `nil`.
	/// - Returns: An initialized `RequestCacheKey` instance, or `nil` if initialization fails.
	///
	/// This initializer creates a cache key with the provided parameters and calculates the expiration date based on the current date and the specified number of days, hours, and minutes. If any of the parameters result in an invalid date, `nil` is returned.
	///
	/// Example usage:
	/// ```swift
	/// if let cacheKey = RequestCacheKey(key: "example", type: .returnCacheDataElseLoad, hours: 1) {
	///     // Use cacheKey
	/// } else {
	///     // Initialization failed
	/// }
	/// ```
	public init?(key: String,
				 type: NetworkCacheType,
				 days: Int? = nil,
				 hours: Int? = nil,
				 minutes: Int? = nil) {
		guard let date = Calendar.current.date(byAdding: DateComponents(day: days,
																		hour: hours,
																		minute: minutes),
											   to: Date())
		else { return nil }
		
		self.key = key
		self.type = type
		self.availableDate = date
	}
}
