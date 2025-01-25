//
//  StyledButton.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//

import SwiftUI

struct StyledButton<Content: View>: View {
    @Environment(\.isEnabled) var isEnabled: Bool

    @ViewBuilder var title: () -> Content
    var backgroundColor: Color = .appYellow
    var onTap: () -> Void

    init(
        title: @autoclosure @escaping () -> Content,
        backgroundColor: Color,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.onTap = onTap
    }

    var body: some View {
        Button(action: onTap) {
            title()
                .button()
                .tint(.appDarkGray)
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets.padding)
                .background(backgroundColor)
                .clipShape(Capsule())
        }
        .buttonStyle(PlainButtonStyle()) // For dimming on disabled
    }
}

// MARK: - StyledButton + LocalizedStringKey

extension StyledButton where Content == Text {
    init(
        key: LocalizedStringKey,
        backgroundColor: Color = .appYellow,
        onTap: @escaping () -> Void
    ) {
        self.init(
            title: Text(key),
            backgroundColor: backgroundColor,
            onTap: onTap
        )
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
