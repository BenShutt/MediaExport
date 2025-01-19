//
//  StickyBottom.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.

//

import SwiftUI

struct StickyBottom<Bottom: View>: ViewModifier {
    @ViewBuilder var bottom: () -> Bottom

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom, spacing: 0) {
                bottom()
                    .background {
                        StickyBottomBackground()
                            .ignoresSafeArea()
                    }
                    .ignoresSafeArea(.keyboard)
            }
    }
}

// MARK: - StickyBottomBackground

private struct StickyBottomBackground: View {
    var body: some View {
        Color.appWhite
            .shadow(
                color: .appDarkGray.opacity(0.15),
                radius: 15,
                x: 0,
                y: 2
            )
    }
}
