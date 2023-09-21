//
//  ResourcesManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI
import Photos

typealias MediaMap = [PHAssetMediaType: [MediaFile]]

@MainActor final class ResourcesManager: ObservableObject {

    private let assetsMap: AssetsMap
    @Published private(set) var state: LoadState<MediaMap> = .idle

    init(assetsMap: AssetsMap) {
        self.assetsMap = assetsMap
    }

    func load() {
        Task {
            await fetchAll()
        }
    }

    private func fetchAll() async {
        guard case .idle = state else { return }

        state = .loading
        do {
            let mediaMap = try await MediaFileMapper.map(assetsMap: assetsMap)
            state = .success(mediaMap)
        } catch {
            state = .failure(error)
        }
    }
}

// MARK: - MediaFileMapper

private struct MediaFileMapper {

    static func map(assetsMap: AssetsMap) async throws -> MediaMap {
        try assetsMap.mapValues { assets in
            try assets.map { asset in
                try MediaFile(
                    fileName: asset.fileName,
                    fileSize: asset.fileSize,
                    asset: asset
                )
            }
        }
    }
}
