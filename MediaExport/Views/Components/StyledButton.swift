//
//  StyledButton.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct StyledButton: View {

    private let foregroundColor: Color = .appDarkGray
    var key: LocalizedStringKey
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(key)
                .style(.button)
                .foregroundStyle(foregroundColor)
                .tint(foregroundColor)
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets.padding)
                .background(Color.appYellow)
                .clipShape(Capsule())
        }
    }
}

// MARK: - Preview

#Preview {
    StyledButton(key: "continue_button", onTap: {})
}
