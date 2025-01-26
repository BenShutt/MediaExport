//
//  MediaExportUITests.swift
//  MediaExportUITests
//
//  Created by Ben Shutt on 18/09/2023.
//

import XCTest

@MainActor
final class MediaExportUITests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
