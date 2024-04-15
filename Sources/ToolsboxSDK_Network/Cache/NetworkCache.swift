//
//  NetworkCache.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

private let kUserDefaultsNetworkCacheName = "ToolsboxSDK.NetworkCache"

public enum NetworkCacheType {
	
	case returnCacheDataElseLoad,
		 returnCacheDataDontLoad
}

public struct RequestCacheKey {
	
	let key: String
	let availableDate: Date
	let type: NetworkCacheType
	
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
	func set(_ datas: Data?, for key: RequestCacheKey) {
		self.defaults?.set(datas, forKey: key.key)
		self.defaults?.set(key.availableDate, forKey: "date_\(key.key)")
		self.defaults?.synchronize()
	}
	
	func get(_ key: RequestCacheKey) -> Data? {
		guard let date = self.defaults?.object(forKey: "date_\(key.key)") as? Date,
			  date >= Date()
		else {
			self.delete(key)
			return nil
		}
		
		return self.defaults?.object(forKey: key.key) as? Data
	}
	
	func delete(_ key: RequestCacheKey) {
		self.defaults?.removeObject(forKey: key.key)
		self.defaults?.removeObject(forKey: "date_\(key.key)")
		self.defaults?.synchronize()
	}
	
	func resetCache() {
		self.defaults?.removePersistentDomain(forName: kUserDefaultsNetworkCacheName)
		self.defaults?.synchronize()
	}
}
