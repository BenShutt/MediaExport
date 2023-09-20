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

    var mediaTypes: [PHAssetMediaType] {
        PhotoLibrary.mediaTypes
    }

    var body: some View {
        Grid {
            GridRow {
                ForEach(mediaTypes[0...1], id: \.rawValue) {
                    GridItem(mediaType: $0, count: 1)
                }
            }
            GridRow {
                ForEach(mediaTypes[2...3], id: \.rawValue) {
                    GridItem(mediaType: $0, count: 1)
                }
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

            Text("media_type_audio_count \(2)")
                .font(.system(size: 8))
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
    MediaGrid()
}