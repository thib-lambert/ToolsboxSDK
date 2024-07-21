//
//  CollectionSafeTests.swift
//
//
//  Created by Thibaud Lambert on 22/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class CollectionSafeTests: XCTestCase {

	func testSafe() {
		let numbers = Array(1...5)
		XCTAssertNotNil(numbers[safe: 2])
		XCTAssertEqual(numbers[safe: 2], 3)
		XCTAssertNil(numbers[safe: 10])
	}
}
