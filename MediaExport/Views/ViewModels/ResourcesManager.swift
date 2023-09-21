//
//  ResourcesManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI
import Photos

@MainActor final class ResourcesManager: ObservableObject {

    private let assetsMap: AssetsMap
    @Published private(set) var state: LoadState<[MediaFile]> = .idle

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
            state = try await .success(MediaFileMapper.map(assetsMap: assetsMap))
        } catch {
            state = .failure(error)
        }
    }
}

// MARK: - MediaFileMapper

private struct MediaFileMapper {

    static func map(assetsMap: AssetsMap) async throws -> [MediaFile] {
        try assetsMap.values.flatMap { assets in
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
