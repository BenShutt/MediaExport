//
//  UploadManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

@MainActor final class UploadManager: ObservableObject {

    enum SyncState {
        case checking(MediaFile)
        case uploading(MediaFile)
    }

    private let mediaFiles: [MediaFile]
    @Published private(set) var syncedMediaFiles: [MediaFile] = []
    @Published private(set) var loadState: LoadState<[MediaFile]> = .idle
    @Published private(set) var syncState: SyncState?

    var value: CGFloat {
        CGFloat(syncedMediaFiles.count)
    }

    var total: CGFloat {
        CGFloat(mediaFiles.count)
    }

    init(mediaFiles: [MediaFile]) {
        self.mediaFiles = mediaFiles
    }

    func sync() {
        Task {
            await syncAll()
        }
    }

    private func syncAll() async {
        guard case .idle = loadState else { return }

        syncedMediaFiles = []
        loadState = .loading
        syncState = nil
        defer { syncState = nil }

        do {
            for mediaFile in mediaFiles {
                try await sync(mediaFile: mediaFile)
            }
            loadState = .success(syncedMediaFiles)
        } catch {
            loadState = .failure(error)
        }
    }

    private func sync(mediaFile: MediaFile) async throws {
        syncState = .checking(mediaFile)
        let exists = try await GetExists.exists(mediaFile: mediaFile)
        if !exists {
            syncState = .uploading(mediaFile)
            try await PostUpload.upload(mediaFile: mediaFile)
        }
        syncedMediaFiles.append(mediaFile)
    }
}
