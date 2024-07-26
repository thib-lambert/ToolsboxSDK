//
//  StringDateTests.swift
//
//
//  Created by Thibaud Lambert on 22/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class StringDateTests: XCTestCase {
	
	func testToDate() throws {
		let dateComponents = DateComponents(timeZone: TimeZone(secondsFromGMT: 0),
											year: 2024,
											month: 4,
											day: 27,
											hour: 15,
											minute: 51,
											second: 0,
											nanosecond: 0)
		let date = try XCTUnwrap(Calendar.current.date(from: dateComponents))
		let stringDate = try XCTUnwrap("2024-04-27T15:51:00+0000".toDate())
		XCTAssertEqual(date, stringDate)
	}
}
