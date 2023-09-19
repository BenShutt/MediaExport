//
//  Screen.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

protocol Screen: View {
    associatedtype ScreenBody: View

    var backgroundColor: Color { get }
    var stickyButton: StickyButton? { get }
    var screen: ScreenBody { get }
}

// MARK: - Extensions

extension Screen {

    var backgroundColor: Color {
        .appWhite
    }

    var stickyButton: StickyButton? {
        nil
    }

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            screen
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .stickyButton(stickyButton)
    }
}
