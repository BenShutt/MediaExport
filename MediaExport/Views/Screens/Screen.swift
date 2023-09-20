//
//  Screen.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct Screen<Content: View>: View {

    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    var stickyButton: StickyButton

    @ViewBuilder var content: () -> Content

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Text(subtitle)
                    .body()
                    .frame(maxWidth: .infinity, alignment: .leading)

                content()
            }
            .multilineTextAlignment(.leading)
            .padding(.top, .vPaddingSmall)
            .padding(.horizontal, .hPadding)
            .padding(.bottom, .vPadding)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.appWhite
                .ignoresSafeArea()
        }
        .modifier(stickyButton)
        .navigationTitle(title)
    }
}
