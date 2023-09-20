//
//  AssetManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

@MainActor final class AssetManager: ObservableObject {

    @Published private(set) var state: LoadState<MediaMap> = .idle

    func load() {
        Task {
            await update()
        }
    }

    private func update() async {
        guard case .idle = state else { return }

        state = .loading
        do {
            state = try await .success(PhotoLibrary.fetchAll())
        } catch {
            state = .failure(error)
        }
    }
}
