//
//  MediaFile.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Photos
import CryptoKit

struct MediaFile: Equatable, Hashable {

    var originalFilename: String
    var fileSize: Int64
    var asset: PHAsset

    var hashId: String {
        let data = Data(asset.localIdentifier.utf8)
        let hashedData = SHA256.hash(data: data)
        let hex = hashedData.compactMap { String(format: "%02x", $0) }
            .joined()
            .prefix(8)
        return String(hex)
    }

    var fileName: String {
        "\(hashId)-\(originalFilename)"
    }

    var mediaType: PHAssetMediaType {
        asset.mediaType
    }

    func data() async throws -> Data {
        try await asset.data()
    }

    var formattedFileSize: String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .binary
        return formatter.string(fromByteCount: fileSize)
    }
}
