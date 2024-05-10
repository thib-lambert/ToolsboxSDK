//
//  NetworkCache.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

/// The name used for storing network cache data in UserDefaults.
private let kUserDefaultsNetworkCacheName = "ToolsboxSDK.NetworkCache"

/// Class responsible for managing network cache data.
class NetworkCache {
	
	// MARK: - Singleton
	static let shared = NetworkCache()
	
	// MARK: - Variables
	private let defaults: UserDefaults?
	
	// MARK: - Init
	private init() {
		self.defaults = UserDefaults(suiteName: kUserDefaultsNetworkCacheName)
	}
	
	// MARK: - Functions
	
	/// Sets the cached data for the specified cache key.
	///
	/// - Parameters:
	///   - datas: The data to be cached.
	///   - key: The cache key.
	///
	/// This method stores the provided data in UserDefaults using the specified cache key. It also stores the expiration date of the cache entry.
	func set(_ datas: Data?, for key: RequestCacheKey) {
		self.defaults?.set(datas, forKey: key.key)
		self.defaults?.set(key.availableDate, forKey: "date_\(key.key)")
		self.defaults?.synchronize()
	}
	
	/// Retrieves the cached data for the specified cache key.
	///
	/// - Parameter key: The cache key.
	/// - Returns: The cached data, or `nil` if the cache entry is expired or not found.
	///
	/// This method retrieves the cached data associated with the specified cache key from UserDefaults. If the cache entry is expired or not found, it deletes the cache entry and returns `nil`.
	func get(_ key: RequestCacheKey) -> Data? {
		guard let date = self.defaults?.object(forKey: "date_\(key.key)") as? Date,
			  date >= Date()
		else {
			self.delete(key)
			return nil
		}
		
		return self.defaults?.object(forKey: key.key) as? Data
	}
	
	/// Deletes the cached data for the specified cache key.
	///
	/// - Parameter key: The cache key.
	///
	/// This method removes the cached data and its associated expiration date from UserDefaults for the specified cache key.
	func delete(_ key: RequestCacheKey) {
		self.defaults?.removeObject(forKey: key.key)
		self.defaults?.removeObject(forKey: "date_\(key.key)")
		self.defaults?.synchronize()
	}
	
	/// Resets the network cache, removing all cached data.
	///
	/// This method removes all cached data and associated expiration dates from UserDefaults, effectively resetting the network cache.
	func resetCache() {
		self.defaults?.removePersistentDomain(forName: kUserDefaultsNetworkCacheName)
		self.defaults?.synchronize()
	}
}
