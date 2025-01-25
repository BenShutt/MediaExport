//
//  ColorUtilitiesTests.swift
//  MediaExportTests
//
//  Created by Ben Shutt on 20/09/2023.
//

import Testing
@testable import MediaExport

@Suite("Unit tests for ColorUtilities")
struct ColorUtilitiesTests {
    @Test func negative() {
        let hexString = ColorUtilities.mappedHexString("#FE98D2", offset: -2)
        #expect(hexString == "#DC76B0")
    }

    @Test func positive() {
        let hexString = ColorUtilities.mappedHexString("#0A8DEF", offset: 2)
        #expect(hexString == "#2CAFEF")
    }

    @Test func boundNegative() {
        let hexString = ColorUtilities.mappedHexString("#91F120", offset: -2)
        #expect(hexString == "#71D100")
    }

    @Test func boundPositive() {
        let hexString = ColorUtilities.mappedHexString("#DF09ED", offset: 2)
        #expect(hexString == "#FF2BEF")
    }

    @Test func blackNegative() {
        let hexString = ColorUtilities.mappedHexString("#000000", offset: -2)
        #expect(hexString == "#000000")
    }

    @Test func whitePositive() {
        let hexString = ColorUtilities.mappedHexString("#FFFFFF", offset: 2)
        #expect(hexString == "#FFFFFF")
    }
}
