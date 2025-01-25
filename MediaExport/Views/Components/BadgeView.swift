//
//  BadgeView.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//

import SwiftUI
import Photos

struct BadgeView: View {
    private let shape = Circle()

    var textWidth: CGFloat = 200
    var symbol: String
    var count: Int
    var subtitle: LocalizedStringKey
    var backgroundColor: Color

    var body: some View {
        VStack(spacing: .vPaddingSmall) {
            Image(systemName: symbol)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .accessibilityHidden(true)

            Text(count, format: .number)
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
        count: 12_345,
        subtitle: "media_file_count",
        backgroundColor: .appWhite
    )
}
