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
    @StateObject private var metaDataManager = MetadataManager()

    init(assetsMap: AssetsMap) {
        _resourcesManager = .init(
            wrappedValue: .init(assetsMap: assetsMap)
        )
    }

    private var mediaFileCount: Int? {
        resourcesManager.state.success?.count
    }

    private var isMetadataDisabled: Bool {
        !resourcesManager.state.isSuccess ||
            metaDataManager.state.isLoading
    }

    private var isContinueDisabled: Bool {
        !resourcesManager.state.isSuccess
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
                        count: mediaFileCount,
                        subtitle: "media_file_count",
                        backgroundColor: .appWhite
                    )
                }
            }
        }
        .modifier(
            StickyBottom {
                VStack(spacing: .vPadding) {
                    StyledButton(
                        key: "metadata_button",
                        backgroundColor: .appGreen,
                        onTap: onMetadata
                    )
                    .disabled(isMetadataDisabled)

                    StyledButton(
                        key: "continue_button",
                        backgroundColor: .appYellow,
                        onTap: onContinue
                    )
                    .disabled(isContinueDisabled)
                }
                .padding(EdgeInsets.padding)
            }
        )
        .sheet(item: $metaDataManager.presentedSheetURL) { url in
            ShareSheet(items: [url.item]) { _, _, _, _ in
                onShareDismissed()
            }
        }
        .task {
            await resourcesManager.load()
        }
    }

    private func onContinue() {
        guard case .success(let mediaFiles) = resourcesManager.state else {
            fatalError("Invalid state \(#function)")
        }
        push(.status(mediaFiles))
    }

    private func onMetadata() {
        Task {
            guard case .success(let mediaFiles) = resourcesManager.state else {
                fatalError("Invalid state \(#function)")
            }
            await metaDataManager.load(media: mediaFiles)
        }
    }

    private func onShareDismissed() {
        Task {
            try? await metaDataManager.clean() // Masked
        }
    }
}

// MARK: - Preview

#Preview {
    ResourcesScreen(assetsMap: [:])
}
