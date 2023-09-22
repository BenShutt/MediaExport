//
//  ResourcesScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

// TODO: This and file sizes aren't needed anymore now we are uploading

struct ResourcesScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var resourcesManager: ResourcesManager

    init(assetsMap: AssetsMap) {
        _resourcesManager = .init(wrappedValue: .init(assetsMap: assetsMap))
    }

    private var maxMediaFile: MediaFile? {
        guard case .success(let mediaFiles) = resourcesManager.state else { return nil }
        return mediaFiles.max { $0.fileSize < $1.fileSize }
    }

    var body: some View {
        Screen(
            title: "resources_title",
            subtitle: "resources_subtitle"
        ) {
            LoadStateView(state: resourcesManager.state) { _ in
                if let maxMediaFile {
                    BadgeView(mediaFile: maxMediaFile)
                }
            }
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

    private func onContinue() {
        guard case .success(let mediaFiles) = resourcesManager.state else { return }
        navigation.push(.status(mediaFiles))
    }
}

// MARK: - Preview

#Preview {
    ResourcesScreen(assetsMap: [:])
        .environmentObject(Navigation())
}
