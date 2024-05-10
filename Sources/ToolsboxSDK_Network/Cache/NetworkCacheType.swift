//
//  NetworkCacheType.swift
//
//
//  Created by Thibaud Lambert on 10/05/2024.
//

import Foundation

/// Enum representing different types of network cache behaviors.
public enum NetworkCacheType {
	
	/// Return cached data if available, otherwise load from network.
	case returnCacheDataElseLoad
	
	/// Return cached data if available, don't load from network.
	case returnCacheDataDontLoad
}
