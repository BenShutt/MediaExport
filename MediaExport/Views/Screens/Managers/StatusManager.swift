//
//  StatusManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.

//

import SwiftUI

@MainActor
final class StatusManager: ObservableObject {
    @Published private(set) var state: LoadState<Int> = .idle

    func reset() {
        state = .idle
    }

    func validate() async {
        guard case .idle = state else { return }
        state = .loading
        do {
            let status = try await GetStatus().requestValue()
            state = .success(status)
        } catch {
            state = .failure(error)
        }
    }
}
