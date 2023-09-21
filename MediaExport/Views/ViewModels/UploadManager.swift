//
//  UploadManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

@MainActor final class UploadManager: ObservableObject {

    private let mediaFiles: [MediaFile]
    @Published private(set) var state: LoadState<Void> = .idle
    @Published var currentMediaFile: MediaFile?
    @Published var lastMediaFile: (MediaFile, existed: Bool)?

    init(mediaFiles: [MediaFile]) {
        self.mediaFiles = mediaFiles
    }

    func sync() {
        Task {
            await syncAll()
        }
    }

    private func syncAll() async {
        guard case .idle = state else { return }

        state = .loading
        defer { currentMediaFile = nil }

        do {
            for mediaFile in mediaFiles {
                try await sync(mediaFile: mediaFile)
            }
            state = .success(())
        } catch {
            state = .failure(error)
        }
    }

    private func sync(mediaFile: MediaFile) async throws {
        currentMediaFile = mediaFile
        if try await Exists.exists(mediaFile: mediaFile) {
            lastMediaFile = (mediaFile, true)
        } else {
            try await Upload.upload(mediaFile: mediaFile)
            lastMediaFile = (mediaFile, false)
        }
    }
}
