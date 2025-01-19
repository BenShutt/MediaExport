//
//  MediaIdTests.swift
//  MediaExportTests
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Testing
@testable import MediaExport

@Suite
struct MediaIdTests {
    @Test func mediaId() async {
        let mediaId = await MediaId(
            localIdentifier: "/path/to/ABC_123.png",
            originalFilename: "IMG_123_456.png"
        )
        #expect(mediaId.description == "9546ec2f-IMG_123_456.png")
    }
}
