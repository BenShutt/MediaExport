//
//  MediaFile.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

struct MediaFile {

    var url: URL
    var mediaType: MediaType

    private init(url: URL, mediaType: MediaType) {
        self.url = url
        self.mediaType = mediaType
    }

    init?(url: URL) {
        let pathExtension = url.pathExtension.lowercased()
        let mediaType = MediaType.allCases.first { mediaType in
            mediaType.pathExtensions.contains(pathExtension)
        }
        guard let mediaType else { return nil }
        self.init(url: url, mediaType: mediaType)
    }
}

// MARK: - MediaType

extension MediaFile {

    enum MediaType: String, CaseIterable {
        case jpeg
        case png
        case heic

        case mov
        case mp4
    }
}

private extension MediaFile.MediaType {

    var pathExtensions: Set<String> {
        var set =  Set([rawValue])
        guard case .jpeg = self else { return set }
        set.insert("jpg")
        return set
    }
}
