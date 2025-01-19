//
//  MediaId.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.

//

import Foundation
import CryptoKit

struct MediaId: CustomStringConvertible {
    let hash: String
    let originalFilename: String

    init(
        localIdentifier: String,
        originalFilename: String
    ) async {
        self.hash = await Self.hash(for: localIdentifier)
        self.originalFilename = originalFilename
    }

    static func hash(for localIdentifier: String) async -> String {
        dispatchPrecondition(condition: .notOnQueue(.main))

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
