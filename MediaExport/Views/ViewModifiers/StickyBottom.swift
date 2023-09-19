//
//  StickyBottom.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct StickyBottom<Bottom: View>: ViewModifier {

    @ViewBuilder var bottom: () -> Bottom

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                bottom()
                    .background {
                        Color.appWhite
                            .ignoresSafeArea()
                            .shadow(.sticky)
                    }
                    .ignoresSafeArea(.keyboard)
            }
    }
}
