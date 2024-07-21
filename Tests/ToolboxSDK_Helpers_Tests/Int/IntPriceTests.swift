//
//  IntPriceTests.swift
//
//
//  Created by Thibaud Lambert on 22/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class IntPriceTests: XCTestCase {
	
	func testToPrice() {
		XCTAssertEqual(20.toPrice(currency: "$"), "20 $")
		XCTAssertEqual(20.toPrice(), "20 €")
		XCTAssertEqual(20.toPrice(currencyCode: "EUR"), "20 €")
		XCTAssertEqual(20.toPrice(currency: "TOTO", currencyCode: "TATA"), "20 TOTO")
		XCTAssertEqual(20.toPrice(currencyCode: "TATA"), "20 €")
	}
}
