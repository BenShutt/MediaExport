//
//  Screen.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

protocol Screen: View {
    associatedtype Content: View

    var title: LocalizedStringKey { get }
    var subtitle: LocalizedStringKey { get }
    var stickyButton: StickyButton { get }
    @ViewBuilder var content: Content { get }

    func onScreenAppear()
}

extension Screen {

    /// By default, do nothing
    func onScreenAppear() {}

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Text(subtitle)
                    .body()
                    .frame(maxWidth: .infinity, alignment: .leading)

                content
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
        .onAppear {
            onScreenAppear()
        }
        .navigationTitle(title)
    }
}
