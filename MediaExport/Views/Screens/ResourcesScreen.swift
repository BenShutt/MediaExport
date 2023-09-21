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
            subtitle: "resources_subtitle",
            stickyButton: StickyButton(key: "continue_button") {
                onContinue()
            }
        ) {
            LoadStateView(state: resourcesManager.state) { mediaMap in
            }
            .padding(.top, .vPaddingLarge)
        }
        .onAppear {
            resourcesManager.load()
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
