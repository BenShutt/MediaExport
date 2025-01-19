//
//  MediaFile.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Photos

struct MediaFile: Equatable, Hashable {
    let originalFilename: String
    let asset: PHAsset
    let fileName: String

    var mediaType: PHAssetMediaType {
        asset.mediaType
    }

    init(
        originalFilename: String,
        asset: PHAsset
    ) async {
        self.originalFilename = originalFilename
        self.asset = asset
        fileName = await MediaId(
            localIdentifier: asset.localIdentifier,
            originalFilename: originalFilename
        ).description
    }

    // MARK: - Async

    func loadData() async throws -> Data {
        switch mediaType {
        case .image: try await ImageFetcher.data(for: asset)
        case .video: try await VideoFetcher.data(for: self)
        default: throw MediaFileError.mediaType
        }
    }
}

// MARK: - MediaFileError

enum MediaFileError: Error, CustomStringConvertible {
    case mediaType

    var description: String {
        switch self {
        case .mediaType: "Unsupported media type"
        }
    }
}
