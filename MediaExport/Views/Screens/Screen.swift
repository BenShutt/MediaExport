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

    var content: Content { get }
}

extension Screen {

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Text(title)
                    .header()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, .vPadding)

                Text(subtitle)
                    .body()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, .vPadding)

                content
            }
            .multilineTextAlignment(.leading)
            .padding(EdgeInsets.padding)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.appWhite
                .ignoresSafeArea()
        }
        .modifier(stickyButton)
    }
}
