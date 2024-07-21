//
//  URLQueryItemsTests.swift
//
//
//  Created by Thibaud Lambert on 22/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class URLQueryItemsTests: XCTestCase {

	func testGetQueryItems() throws {
		let urlWithQueryItems = try XCTUnwrap(URL("https://my.url?param1=toto&param2=tata"))
		let urlWithoutQueryItems = try XCTUnwrap(URL("https://my.url"))
		
		XCTAssertEqual(urlWithQueryItems.getQueryItems(),
					   [
						"param1": "toto",
						"param2": "tata"
					   ])
		XCTAssertEqual(urlWithoutQueryItems.getQueryItems(), [:])
	}
}
