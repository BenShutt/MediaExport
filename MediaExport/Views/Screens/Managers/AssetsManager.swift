//
//  AssetsManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI
import Photos

typealias AssetsMap = [PHAssetMediaType: [PHAsset]]

@MainActor final class AssetsManager: ObservableObject {

    private let mediaTypes: [PHAssetMediaType] = [.unknown, .image, .video, .audio]
    @Published private(set) var state: LoadState<AssetsMap> = .idle

    func load() {
        Task {
            await loadAsync()
        }
    }

    private func loadAsync() async {
        guard case .idle = state else { return }

        state = .loading
        do {
            state = try await .success(fetchAll())
        } catch {
            state = .failure(error)
        }
    }

    private func fetchAll(for mediaType: PHAssetMediaType) throws -> [PHAsset] {
        let isAuthorized = AuthorizationManager.isAuthorized()
        guard isAuthorized else { throw AssetsManagerError.authorization }

        var assets: [PHAsset] = []
        PHAsset.fetchAssets(
            with: mediaType,
            options: PHFetchOptions()
        ).enumerateObjects { asset, _, _ in
            assets.append(asset)
        }
        return assets
    }

    private func fetchAll() async throws -> AssetsMap {
        try mediaTypes.reduce(into: [:]) { map, mediaType in
            map[mediaType, default: []] += try fetchAll(for: mediaType)
        }
    }
}

// MARK: - AssetsManagerError

enum AssetsManagerError: Error {

    case authorization
}
