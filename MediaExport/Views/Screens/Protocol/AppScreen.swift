//
//  AppScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

protocol AppScreen: Screen {
    associatedtype Content: View

    var title: LocalizedStringKey { get }
    var subtitle: LocalizedStringKey { get }
    var isEnabled: Bool { get }
    var content: Content { get }

    func onContinue()
}

extension AppScreen {

    var stickyButton: StickyButton? {
        StickyButton(
            key: "continue_button",
            isEnabled: isEnabled
        ) {
            onContinue()
        }
    }

    var screen: some View {
        ScrollView {
            LazyVStack(spacing: .vPadding) {
                Text(title)
                    .header()
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(subtitle)
                    .body()
                    .frame(maxWidth: .infinity, alignment: .leading)

                content
            }
            .multilineTextAlignment(.leading)
            .padding(EdgeInsets.padding)
        }
    }
}
