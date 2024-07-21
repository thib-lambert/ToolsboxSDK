//
//  SequenceGroupTests.swift
//
//
//  Created by Thibaud Lambert on 22/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class SequenceGroupTests: XCTestCase {
	
	func testGroup() {
		let numbers = Array(1...10)
		let groupedNumbers = numbers.group { $0.isMultiple(of: 2) ? "Even" : "Odd" }
		
		XCTAssertEqual(groupedNumbers.keys.count, 2)
		XCTAssertEqual(groupedNumbers["Even"], [2, 4, 6, 8, 10])
		XCTAssertEqual(groupedNumbers["Even"]?.count, 5)
		XCTAssertEqual(groupedNumbers["Odd"], [1, 3, 5, 7, 9])
		XCTAssertEqual(groupedNumbers["Odd"]?.count, 5)
	}
}
