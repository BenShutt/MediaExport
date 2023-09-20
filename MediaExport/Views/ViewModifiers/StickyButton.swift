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
    var isEnabled: Bool
    var onTap: () -> Void

    func body(content: Content) -> some View {
        content.modifier(
            StickyBottom {
                StyledButton(key: key, onTap: onTap)
                    .disabled(!isEnabled)
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets.padding)
            }
        )
    }
}
