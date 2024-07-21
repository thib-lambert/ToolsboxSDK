//
//  URLOptionalTests.swift
//
//
//  Created by Thibaud Lambert on 22/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class URLOptionalTests: XCTestCase {
	
	func testInit() {
		XCTAssertNil(URL(nil))
		XCTAssertNotNil(URL("https://apple.com"))
	}
}
