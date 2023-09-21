//
//  BadgeView.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct BadgeView: View {

    var textWidth: CGFloat = 200
    var title: String
    var subtitle: LocalizedStringKey
    var backgroundColor: Color

    private var shape: some InsettableShape {
        Circle()
    }

    var body: some View {
        VStack(spacing: .vPaddingSmall) {
            Text(verbatim: title)
                .badge()

            Text(subtitle)
                .caption()
        }
        .multilineTextAlignment(.center)
        .frame(width: textWidth)
        .padding(textWidth * 0.4)
        .background {
            backgroundColor
                .clipShape(shape)
                .overlay {
                    shape.strokeBorder(Color.appBlack, lineWidth: .border)
                }
        }
    }
}

// MARK: - BadgeView

#Preview {
    BadgeView(
        title: "102MB",
        subtitle: "Badge Preview",
        backgroundColor: .pastelGreen
    )
}
