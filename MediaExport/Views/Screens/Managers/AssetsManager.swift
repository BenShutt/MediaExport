//
//  AssetsManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.
//

import SwiftUI
import Photos

typealias AssetsMap = [PHAssetMediaType: [PHAsset]]

@MainActor
final class AssetsManager: ObservableObject {
    let mediaTypes: [PHAssetMediaType] = [.unknown, .image, .video, .audio]
    let photoAuthorization: PhotoAuthorization
    @Published private(set) var state: LoadState<AssetsMap> = .idle

    init(photoAuthorization: PhotoAuthorization = AuthorizationManager()) {
        self.photoAuthorization = photoAuthorization
    }

    // TODO: Improve LoadState code re-use
    func load() async {
        guard case .idle = state else { return }
        state = .loading
        do {
            state = try await .success(fetchAll())
        } catch {
            state = .failure(error)
        }
    }

    private nonisolated func fetchAll(
        for mediaType: PHAssetMediaType
    ) async throws -> [PHAsset] {
        try await photoAuthorization.checkAuthorized()

        // Ignore iCloud and iTunes media
        let options = PHFetchOptions()
        options.includeAssetSourceTypes = [.typeUserLibrary]

        var assets: [PHAsset] = []
        PHAsset.fetchAssets(
            with: mediaType,
            options: options
        )
        .enumerateObjects { asset, _, _ in
            assets.append(asset)
        }
        return assets
    }

    private nonisolated func fetchAll() async throws -> AssetsMap {
        try await withThrowingTaskGroup(
            of: (PHAssetMediaType, [PHAsset]).self
        ) { group in
            for mediaType in mediaTypes {
                group.addTask {
                    let assets = try await self.fetchAll(for: mediaType)
                    return (mediaType, assets)
                }
            }

            return try await group.reduce(into: [:]) { map, tuple in
                map[tuple.0] = tuple.1
            }
        }
    }
}

// MARK: - AssetsManagerError

enum AssetsManagerError: Error {
    case authorization
}
