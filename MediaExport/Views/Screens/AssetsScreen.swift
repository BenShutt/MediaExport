//
//  AssetsScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct AssetsScreen: View {

    @StateObject private var assetManager = AssetManager()

    var body: some View {
        Screen(
            title: "assets_title",
            subtitle: "assets_subtitle",
            stickyButton: StickyButton(key: "continue_button") {
                onContinue()
            }
        ) {
            StateView(state: assetManager.state)
                .padding(.top, .vPaddingLarge)
        }
        .onAppear {
            assetManager.load()
        }
    }

    private func onContinue() {
        // TODO
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
