//
//  StyledButton.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct StyledButton: View {

    @Environment(\.isEnabled) var isEnabled: Bool

    var key: LocalizedStringKey
    var backgroundColor: Color = .appYellow
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(key)
                .style(.button)
                .foregroundStyle(Color.appDarkGray)
                .tint(.appDarkGray)
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets.padding)
                .background(backgroundColor)
                .clipShape(Capsule())
        }
        .buttonStyle(PlainButtonStyle()) // For dimming on disabled
    }
}

// MARK: - Preview

#Preview {
    VStack {
        StyledButton(key: "continue_button", onTap: {})

        StyledButton(key: "continue_button", onTap: {})
            .disabled(true)
    }
}
