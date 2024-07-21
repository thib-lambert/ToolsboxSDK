//
//  IntDistanceTests.swift
//  
//
//  Created by Thibaud Lambert on 25/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class IntDistanceTests: XCTestCase {
	
	func testToWeight() {
		XCTAssertEqual(10.toDistance(), "10 m")
		XCTAssertEqual(10.toDistance(locale: Locale(identifier: "en")), "33 pi")
	}
}
