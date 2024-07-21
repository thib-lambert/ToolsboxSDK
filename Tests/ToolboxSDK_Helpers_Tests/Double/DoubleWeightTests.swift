//
//  DoubleWeightTests.swift
//  
//
//  Created by Thibaud Lambert on 25/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class DoubleWeightTests: XCTestCase {
	
	func testToWeight() {
		let weight = 20.0
		
		XCTAssertEqual(weight.toWeight(), "20,00 kg")
	}
}
