//
//  AssetsScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

// TODO: Make authorization screen

struct AssetsScreen: Screen {

    @StateObject private var assetManager = AssetManager()

    let title: LocalizedStringKey = "assets_title"
    let subtitle: LocalizedStringKey = "assets_subtitle"

    var stickyButton: StickyButton {
        StickyButton(
            key: "continue_button",
            isEnabled: true
        ) {
            // TODO
        }
    }

    var content: some View {
        StateView(state: assetManager.state)
            .padding(.top, .vPadding)
    }

    func onScreenAppear() {
        assetManager.load()
    }
}

// MARK: - StateView

private struct StateView: View {

    var state: LoadState<MediaMap>

    var body: some View {
        switch state {
        case let .success(map):
            MediaGrid(map: map)
        case let .failure(error):
            Text(verbatim: error.localizedDescription)
                .body()
        default:
            LoadingView()
        }
    }
}

// MARK: - Preview

#Preview {
    AssetsScreen()
}
