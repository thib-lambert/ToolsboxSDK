//
//  Collection+Safe.swift
//  
//
//  Created by Thibaud Lambert on 27/04/2024.
//

import Foundation

public extension Collection {
	
	subscript(safe index: Index) -> Element? {
		indices.contains(index) ? self[index] : nil
	}
}
