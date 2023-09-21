//
//  ResourcesScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct ResourcesScreen: View {

    var body: some View {
        Screen(
            title: "resources_title",
            subtitle: "resources_subtitle",
            stickyButton: StickyButton(key: "continue_button") {
                onContinue()
            }
        ) {
        }
    }

    private func onContinue() {
        // TODO
    }
}

// MARK: - Preview

#Preview {
    ResourcesScreen()
}
