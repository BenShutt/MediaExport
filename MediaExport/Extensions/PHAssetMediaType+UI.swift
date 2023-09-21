//
//  PHAssetMediaType+UI.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI
import Photos

extension PHAssetMediaType {

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
