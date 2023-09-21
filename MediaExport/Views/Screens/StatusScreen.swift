//
//  StatusScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct StatusScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var statusManager = StatusManager()

    var mediaFiles: [MediaFile]

    var body: some View {
        Screen(
            title: "status_title",
            subtitle: "status_subtitle"
        ) {
            LoadStateView(state: statusManager.state) { _ in
                SuccessView()
                    .frame(size: 250)
            }
        }
        .modifier(
            StickyButton(
                key: "continue_button",
                isEnabled: statusManager.state.isFinished,
                onTap: { onContinue() }
            )
        )
        .onAppear {
            statusManager.validate {
                // Do nothing
            }
        }
    }

    private func onContinue() {
        guard statusManager.state.isFinished else { return }
        statusManager.state = .idle

        statusManager.validate {
            navigation.push(.upload(mediaFiles))
        }
    }
}

// MARK: - Preview

#Preview {
    StatusScreen(mediaFiles: [])
        .environmentObject(Navigation())
}
