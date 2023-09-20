//
//  PhotoLibrary.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Photos

typealias MediaMap = [PHAssetMediaType: [PHAsset]]

final class PhotoLibrary {

    static func requestAuthorization() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { _ in }
    }

    static var mediaTypes: [PHAssetMediaType] {
        [.unknown, .image, .video, .audio]
    }

    static func fetchAll(for mediaType: PHAssetMediaType) -> [PHAsset] {
        var assets: [PHAsset] = []
        PHAsset.fetchAssets(
            with: mediaType,
            options: PHFetchOptions()
        ).enumerateObjects { asset, _, _ in
            assets.append(asset)
        }
        return assets
    }

    static func fetchAll() async throws -> MediaMap {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        guard status == .authorized else { throw PhotoLibraryError.authorization }
        return mediaTypes.reduce(into: [:]) { map, mediaType in
            map[mediaType, default: []] += fetchAll(for: mediaType)
        }
    }

    static func format(byteCount: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .binary
        return formatter.string(fromByteCount: byteCount)
    }
}

// MARK: - PhotoLibraryError

enum PhotoLibraryError: Error {

    case authorization
}
