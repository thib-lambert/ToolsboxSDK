//
//  Logger+ToolsboxSDK.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation
import os

extension Logger {
	
	private static let subsystem = "ToolsboxSDK"
	
	#warning("Check if public is not public out the SDK")
	public static let network = Logger(subsystem: Self.subsystem, category: "Network")
	public static let data = Logger(subsystem: Self.subsystem, category: "Data")
}
