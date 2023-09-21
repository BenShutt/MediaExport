//
//  MediaFile.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Photos

struct MediaFile: Equatable, Hashable {

    var originalFilename: String
    var fileSize: Int64
    var asset: PHAsset

    // MARK: - Computed

    var fileName: String {
        MediaId(mediaFile: self).description
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
