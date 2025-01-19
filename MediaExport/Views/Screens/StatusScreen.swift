//
//  StatusScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.

//

import SwiftUI

struct StatusScreen: View {
    @Environment(\.push) private var push
    @StateObject private var statusManager = StatusManager()

    var mediaFiles: [MediaFile]

    private var state: LoadState<Int> {
        statusManager.state
    }

    var body: some View {
        Screen(
            title: "status_title",
            subtitle: "status_subtitle"
        ) {
            LoadStateView(state: state) { _ in
                SuccessView()
                    .frame(width: 250, height: 250)
            }
        }
        .modifier(
            StickyButton(
                key: "continue_button",
                isEnabled: state.isFinished,
                onTap: {
                    Task { await onContinue() }
                }
            )
        )
        .task {
            await statusManager.validate()
        }
    }

    private func onContinue() async {
        guard state.isFinished else { return }

        statusManager.reset()
        await statusManager.validate()
        guard state.isSuccess else { return }
        push(.upload(mediaFiles))
    }
}

// MARK: - Preview

#Preview {
    StatusScreen(mediaFiles: [])
}
