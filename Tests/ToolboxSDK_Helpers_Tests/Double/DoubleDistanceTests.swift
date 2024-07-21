//
//  DoubleDistanceTests.swift
//  
//
//  Created by Thibaud Lambert on 25/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class DoubleDistanceTests: XCTestCase {
	
	func testToDistance() {
		XCTAssertEqual((24.5).toDistance(), "24,50 m")
		XCTAssertEqual((24.5).toDistance(locale: Locale(identifier: "en")), "80,38 pi")
	}
}
