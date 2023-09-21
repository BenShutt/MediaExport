//
//  ResourcesScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct ResourcesScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var resourcesManager: ResourcesManager

    init(assetsMap: AssetsMap) {
        _resourcesManager = .init(wrappedValue: .init(assetsMap: assetsMap))
    }

    var body: some View {
        Screen(
            title: "resources_title",
            subtitle: "resources_subtitle"
        ) {
            LoadStateView(state: resourcesManager.state) { mediaMap in
                if let mediaFile = maxMediaFile(from: mediaMap) {
                    BadgeView(mediaFile: mediaFile)
                }
            }
            .padding(.top, .vPaddingLarge)
        }
        .modifier(
            StickyButton(
                key: "continue_button",
                isEnabled: resourcesManager.state.isSuccess,
                onTap: { onContinue() }
            )
        )
        .onAppear {
            resourcesManager.load()
        }
    }

    private func maxMediaFile(from mediaMap: MediaMap) -> MediaFile? {
        mediaMap.values.flatMap { $0 }.max { f1, f2 in
            f1.fileSize < f2.fileSize
        }
    }

    private func onContinue() {
        // TODO
    }
}

// MARK: - Preview

#Preview {
    ResourcesScreen(assetsMap: [:])
        .environmentObject(Navigation())
}
