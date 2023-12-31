//
//  BadgeView.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI
import Photos

struct BadgeView: View {

    var textWidth: CGFloat = 200
    var symbol: String
    var title: String
    var subtitle: LocalizedStringKey
    var backgroundColor: Color

    private var shape: some InsettableShape {
        Circle()
    }

    var body: some View {
        VStack(spacing: .vPaddingSmall) {
            Image(systemName: symbol)
                .resizable()
                .scaledToFit()
                .frame(size: 50)

            Text(verbatim: title)
                .badge()
                .lineLimit(1)
                .minimumScaleFactor(0.25)

            Text(subtitle)
                .caption()
        }
        .multilineTextAlignment(.center)
        .foregroundStyle(Color.appBlack)
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
        symbol: "number",
        title: "12,345",
        subtitle: "media_file_count",
        backgroundColor: .appWhite
    )
}
