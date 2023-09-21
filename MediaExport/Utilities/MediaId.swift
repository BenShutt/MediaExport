//
//  MediaId.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import CryptoKit

struct MediaId: CustomStringConvertible {

    var localIdentifier: String
    var originalFilename: String

    var hash: String {
        let data = Data(localIdentifier.utf8)
        let hashedData = SHA256.hash(data: data)
        let hexString = hashedData
            .compactMap { String(format: "%02x", $0) }
            .joined()
            .prefix(8)
        return String(hexString)
    }

    var description: String {
        "\(hash)-\(originalFilename)"
    }
}

// MARK: - Extensions

extension MediaId {

    init(mediaFile: MediaFile) {
        localIdentifier = mediaFile.asset.localIdentifier
        originalFilename = mediaFile.originalFilename
    }
}
