//
//  StickyButton.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct StickyButton: ViewModifier {

    var key: LocalizedStringKey
    var backgroundColor: Color = .appYellow
    var isEnabled = true
    var onTap: () -> Void

    func body(content: Content) -> some View {
        content.modifier(
            StickyBottom {
                StyledButton(
                    key: key,
                    backgroundColor: backgroundColor,
                    onTap: onTap
                )
                .disabled(!isEnabled)
                .padding(EdgeInsets.padding)
            }
        )
    }
}
