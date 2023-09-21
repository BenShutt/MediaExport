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
            let mediaFiles = try await MediaFileMapper.map(assetsMap: assetsMap)
            try checkDuplicates(in: mediaFiles)
            state = .success(mediaFiles)
        } catch {
            state = .failure(error)
        }
    }

    private func checkDuplicates(in mediaFiles: [MediaFile]) throws {
        var fileNames: Set<String> = []
        var duplicates: [String] = []

        mediaFiles.forEach { mediaFile in
            let fileName = mediaFile.fileName
            if fileNames.contains(fileName) {
                duplicates.append(fileName)
            } else {
                fileNames.insert(fileName)
            }
        }

        guard duplicates.isEmpty else {
            throw ResourcesManagerError.duplicates(duplicates)
        }
    }
}

// MARK: - MediaFileMapper

private struct MediaFileMapper {

    static func map(assetsMap: AssetsMap) async throws -> [MediaFile] {
        try assetsMap.values.flatMap { assets in
            try assets.map { asset in
                try MediaFile(
                    originalFilename: asset.originalFilename,
                    fileSize: asset.fileSize,
                    asset: asset
                )
            }
        }
    }
}

// MARK: - ResourcesManagerError

enum ResourcesManagerError: Error {

    case duplicates([String])
}
