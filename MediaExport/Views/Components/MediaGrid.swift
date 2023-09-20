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

    var map: MediaMap

    var rows: [[PHAssetMediaType]] {
        [[.image, .video], [.audio, .unknown]]
    }

    var body: some View {
        Grid {
            MediaGridRow(row: rows[0], map: map)
            MediaGridRow(row: rows[1], map: map)
        }
    }
}

// MARK: - MediaGridRow

private struct MediaGridRow: View {

    var row: [PHAssetMediaType]
    var map: MediaMap

    private func count(for mediaType: PHAssetMediaType) -> Int {
        map[mediaType]?.count ?? -1
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

// MARK: - PHAssetMediaType + Extensions

private extension PHAssetMediaType {

    func title(count: Int) -> LocalizedStringKey {
        switch self {
        case .image: "media_type_image_count \(count)"
        case .video: "media_type_video_count \(count)"
        case .audio: "media_type_audio_count \(count)"
        default: "media_type_unknown_count \(count)"
        }
    }

    var color: Color {
        switch self {
        case .image: .pastelBlue
        case .video: .pastelGreen
        case .audio: .pastelRed
        default: .pastelYellow
        }
    }

    var symbol: String {
        switch self {
        case .image: "person.fill"
        case .video: "video.fill"
        case .audio: "music.note.list"
        default: "doc.fill"
        }
    }

    var borderColor: Color {
        ColorUtilities.mappedColor(color, offset: -1)
    }

    var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                ColorUtilities.mappedColor(color, offset: 1),
                color
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Preview

#Preview {
    MediaGrid(map: [:])
}
