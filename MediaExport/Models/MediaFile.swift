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
    var asset: PHAsset

    // MARK: - Computed

    var fileName: String {
        MediaId(mediaFile: self).description
    }

    var mediaType: PHAssetMediaType {
        asset.mediaType
    }

    func data() async throws -> Data {
        switch mediaType {
        case .image: return try await ImageFetcher.data(for: asset)
        case .video: return try await VideoFetcher.data(for: self)
        default: throw MediaFileError.data
        }
    }
}

// MARK: - MediaFileError

enum MediaFileError: Error {

    case data
}
