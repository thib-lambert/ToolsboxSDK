//
//  SequenceLimitTests.swift
//  
//
//  Created by Thibaud Lambert on 22/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class SequenceLimitTests: XCTestCase {

	func testLimit() {
		let array = Array(1...10)
		XCTAssertEqual(array.limit(5).count, 5)
		XCTAssertEqual(array.limit(5), [1, 2, 3, 4, 5])
		XCTAssertNotEqual(array.limit(5), [1, 3, 2, 5, 4])
	}
}
