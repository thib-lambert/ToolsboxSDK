//
//  DateStringTests.swift
//
//
//  Created by Thibaud Lambert on 22/07/2024.
//

import Foundation
import XCTest
@testable import ToolsboxSDK_Helpers

final class DateStringTests: XCTestCase {
	
	func testToString() throws {
		let dateComponents = DateComponents(timeZone: TimeZone(secondsFromGMT: 0),
											year: 2024,
											month: 4,
											day: 27,
											hour: 15,
											minute: 51,
											second: 0,
											nanosecond: 0)
		let date = try XCTUnwrap(Calendar.current.date(from: dateComponents))
		
		XCTAssertEqual(date.toString(format: "yyyy-MM-dd"), "2024-04-27")
		XCTAssertEqual(date.toString(dateStyle: .medium, timeStyle: .short), "27 avr. 2024 à 17:51")
	}
}
