//
//  AssetsScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct AssetsScreen: Screen {

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
        MediaGrid()
            .padding(.top, .vPadding)
    }
}

// MARK: - Preview

#Preview {
    AssetsScreen()
}
