//
//  IntWeightTests.swift
//
//
//  Created by Thibaud Lambert on 25/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class IntWeightTests: XCTestCase {
	
	func testToWeight() {
		XCTAssertEqual(20.toWeight(), "20 kg")
		XCTAssertEqual(2000.toWeight(), "2000 kg")
	}
}
