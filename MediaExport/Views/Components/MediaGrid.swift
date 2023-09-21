//
//  MediaGrid.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI
import Photos

struct MediaGrid: View {

    var assetsMap: AssetsMap

    var rows: [[PHAssetMediaType]] {
        [[.image, .video], [.audio, .unknown]]
    }

    var body: some View {
        Grid {
            MediaGridRow(row: rows[0], assetsMap: assetsMap)
            MediaGridRow(row: rows[1], assetsMap: assetsMap)
        }
    }
}

// MARK: - MediaGridRow

private struct MediaGridRow: View {

    var row: [PHAssetMediaType]
    var assetsMap: AssetsMap

    private func count(for mediaType: PHAssetMediaType) -> Int {
        assetsMap[mediaType]?.count ?? -1
    }

    var body: some View {
        GridRow {
            ForEach(row, id: \.rawValue) { mediaType in
                GridItem(
                    mediaType: mediaType,
                    count: count(for: mediaType)
                )
            }
        }
    }
}

// MARK: - GridItem

private struct GridItem: View {

    var mediaType: PHAssetMediaType
    var count: Int

    var border: some InsettableShape {
        RoundedRectangle(cornerRadius: .corners)
    }

    var body: some View {
        VStack(spacing: .vPadding) {
            Image(systemName: mediaType.symbol)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .foregroundStyle(Color.appDarkGray)

            Text(mediaType.title(count: count))
                .caption()
                .lineLimit(1)
                .minimumScaleFactor(0.25)
        }
        .padding(.vertical, .vPaddingLarge)
        .padding(.horizontal, .hPadding)
        .frame(maxWidth: .infinity)
        .background {
            mediaType.backgroundGradient
                .overlay {
                    border.strokeBorder(mediaType.borderColor, lineWidth: 2)
                }
                .clipShape(border)
        }
    }
}

// MARK: - Preview

#Preview {
    MediaGrid(assetsMap: [:])
}
