//
//  File.swift
//  
//
//  Created by Thibaud Lambert on 22/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class DoublePriceTests: XCTestCase {
	
	func testToPrice() {
		XCTAssertEqual((20.4).toPrice(currency: "$", minimumFractionDigits: 0), "20,4 $")
		XCTAssertEqual((20.4).toPrice(currency: "$", minimumFractionDigits: 5), "20,40000 $")
		XCTAssertEqual((20.4).toPrice(currency: "$",
									 minimumFractionDigits: 1,
									 maximumFractionDigits: 5), "20,4 $")
		XCTAssertEqual((20.4).toPrice(currency: "$"), "20,40 $")
		
		XCTAssertEqual((20.4).toPrice(currencyCode: "EUR", minimumFractionDigits: 0), "20,4 €")
		XCTAssertEqual((20.4).toPrice(currencyCode: "EUR", minimumFractionDigits: 5), "20,40000 €")
		XCTAssertEqual((20.4).toPrice(currencyCode: "EUR",
									 minimumFractionDigits: 1,
									 maximumFractionDigits: 5), "20,4 €")
		XCTAssertEqual((20.4).toPrice(currencyCode: "EUR"), "20,40 €")
		XCTAssertEqual((20.4).toPrice(currencyCode: "EUR",
									 minimumFractionDigits: 0,
									 maximumFractionDigits: 0), "20 €")
		
		XCTAssertEqual((10.0).toPrice(), "10,00 €")
		XCTAssertEqual((10.0).toPrice(currency: "TOTO", currencyCode: "TATA"), "10,00 TOTO")
		XCTAssertEqual((10.0).toPrice(currencyCode: "TATA"), "10,00 €")
	}
}
