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

    private static let accessLevel: PHAccessLevel = .readWrite

    static func isAuthorized() -> Bool {
        PHPhotoLibrary.authorizationStatus(for: accessLevel) == .authorized
    }

    static func requestAuthorization(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: accessLevel) { _ in
            DispatchQueue.main.async {
                completion(isAuthorized())
            }
        }
    }

    static var mediaTypes: [PHAssetMediaType] {
        [.unknown, .image, .video, .audio]
    }

    static func fetchAll(for mediaType: PHAssetMediaType) throws -> [PHAsset] {
        guard isAuthorized() else { throw PhotoLibraryError.authorization }
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
        try mediaTypes.reduce(into: [:]) { map, mediaType in
            map[mediaType, default: []] += try fetchAll(for: mediaType)
        }
    }
}

// MARK: - PhotoLibraryError

enum PhotoLibraryError: Error {

    case authorization
}
