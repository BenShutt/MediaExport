//
//  MediaIdTests.swift
//  MediaExportTests
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import XCTest
@testable import MediaExport

final class MediaIdTests: XCTestCase {

    func test() {
        let originalFileName = "IMG_123_456.png"
        let localIdentifier = "/path/to/ABC_123.png"

        let mediaId = MediaId(
            localIdentifier: localIdentifier,
            originalFilename: originalFileName
        )
        XCTAssertEqual(mediaId.description, "9546ec2f-\(originalFileName)")
    }
}
