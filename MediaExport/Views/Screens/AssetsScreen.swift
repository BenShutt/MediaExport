//
//  AssetsScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct AssetsScreen: AppScreen {

    var title: LocalizedStringKey { "assets_title" }
    var subtitle: LocalizedStringKey { "assets_subtitle" }
    var isEnabled: Bool { true }

    var content: some View {
        EmptyView()
    }

    func onContinue() {
    }
}

// MARK: - Preview

#Preview {
    AssetsScreen()
}
