//
//  ColorUtilitiesTests.swift
//  MediaExportTests
//
//  Created by Ben Shutt on 20/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import XCTest
@testable import MediaExport

final class ColorUtilitiesTests: XCTestCase {

    func testNegative() {
        let hexString = ColorUtilities.mappedHexString("#FE98D2", offset: -2)
        XCTAssertEqual(hexString, "#DC76B0")
    }

    func testPositive() {
        let hexString = ColorUtilities.mappedHexString("#0A8DEF", offset: 2)
        XCTAssertEqual(hexString, "#2CAFEF")
    }

    func testBoundNegative() {
        let hexString = ColorUtilities.mappedHexString("#91F120", offset: -2)
        XCTAssertEqual(hexString, "#71D100")
    }

    func testBoundPositive() {
        let hexString = ColorUtilities.mappedHexString("#DF09ED", offset: 2)
        XCTAssertEqual(hexString, "#FF2BEF")
    }

    func testBlackNegative() {
        let hexString = ColorUtilities.mappedHexString("#000000", offset: -2)
        XCTAssertEqual(hexString, "#000000")
    }

    func testWhitePositive() {
        let hexString = ColorUtilities.mappedHexString("#FFFFFF", offset: 2)
        XCTAssertEqual(hexString, "#FFFFFF")
    }
}
