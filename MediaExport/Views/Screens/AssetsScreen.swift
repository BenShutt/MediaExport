//
//  AssetsScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct AssetsScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var assetsManager = AssetsManager()

    var body: some View {
        Screen(
            title: "assets_title",
            subtitle: "assets_subtitle"
        ) {
            LoadStateView(state: assetsManager.state) { assetsMap in
                MediaGrid(assetsMap: assetsMap)
            }
        }
        .modifier(
            StickyButton(
                key: "continue_button",
                isEnabled: assetsManager.state.isSuccess,
                onTap: { onContinue() }
            )
        )
        .onAppear {
            assetsManager.load()
        }
    }

    private func onContinue() {
        guard case .success(let assetsMap) = assetsManager.state else { return }
        navigation.push(.resources(assetsMap))
    }
}

// MARK: - Preview

#Preview {
    AssetsScreen()
        .environmentObject(Navigation())
}
