//
//  ResourcesManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

@MainActor final class ResourcesManager: ObservableObject {

    @Published private(set) var state: LoadState<[MediaFile]> = .idle

    var map: MediaMap

    init(map: MediaMap) {
        self.map = map
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
            // TODO
        } catch {
            state = .failure(error)
        }
    }
}
