//
//  ResourcesScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.

//

import SwiftUI

struct ResourcesScreen: View {
    @Environment(\.push) private var push
    @StateObject private var resourcesManager: ResourcesManager

    init(assetsMap: AssetsMap) {
        _resourcesManager = .init(wrappedValue: .init(assetsMap: assetsMap))
    }

    private var mediaFileCount: String? {
        guard case .success(let mediaFiles) = resourcesManager.state else { return nil }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: mediaFiles.count as NSNumber)
    }

    var body: some View {
        Screen(
            title: "resources_title",
            subtitle: "resources_subtitle"
        ) {
            LoadStateView(state: resourcesManager.state) { _ in
                if let mediaFileCount {
                    BadgeView(
                        symbol: "number",
                        title: mediaFileCount,
                        subtitle: "media_file_count",
                        backgroundColor: .appWhite
                    )
                }
            }
        }
        .modifier(
            StickyButton(
                key: "continue_button",
                isEnabled: resourcesManager.state.isSuccess,
                onTap: onContinue
            )
        )
        .task {
            await resourcesManager.load()
        }
    }

    private func onContinue() {
        guard case .success(let mediaFiles) = resourcesManager.state else { return }
        push(.status(mediaFiles))
    }
}

// MARK: - Preview

#Preview {
    ResourcesScreen(assetsMap: [:])
}
