//
//  StatusManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

@MainActor final class StatusManager: ObservableObject {

    @Published var state: LoadState<Int> = .idle

    func validate(completion: @escaping (Bool) -> Void) {
        Task {
            await validate()
            completion(state.isSuccess)
        }
    }

    private func validate() async {
        guard case .idle = state else { return }

        state = .loading
        do {
            state = try await .success(GetStatus.validate())
        } catch {
            state = .failure(error)
        }
    }
}
