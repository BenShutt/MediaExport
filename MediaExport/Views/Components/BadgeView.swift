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
    var sfSymbol: String
    var title: String
    var subtitle: LocalizedStringKey
    var backgroundColor: Color

    private var shape: some InsettableShape {
        Circle()
    }

    var body: some View {
        VStack(spacing: .vPaddingSmall) {
            Image(systemName: sfSymbol)
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

// MARK: - BadgeView + MediaFile

extension BadgeView {

    init(mediaFile: MediaFile) {
        self.init(
            sfSymbol: mediaFile.mediaType.symbol,
            title: mediaFile.formattedFileSize,
            subtitle: "max_size",
            backgroundColor: mediaFile.mediaType.color
        )
    }
}

// MARK: - BadgeView

#Preview {
    BadgeView(
        sfSymbol: PHAssetMediaType.video.symbol,
        title: "12345.678 MB",
        subtitle: "max_size",
        backgroundColor: PHAssetMediaType.video.color
    )
}
