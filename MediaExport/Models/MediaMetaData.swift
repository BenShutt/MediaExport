//
//  MediaMetaData.swift
//  MediaExport
//
//  Created by Ben Shutt on 25/01/2025.
//  Copyright © 2025 Ben Shutt. All rights reserved.
//

import Foundation
import Photos

struct MediaMetaData: Sendable, Equatable, Hashable, Codable, Comparable {
    var fileName: String
    var mediaType: String?
    var creationDate: Date?
    var location: String?
    var duration: TimeInterval?
    var modificationDate: Date?
    var sourceType: String?
    var subType: String?

    init(media: MediaFile) {
        fileName = media.fileName
        mediaType = media.asset.mediaType.mediaDescription
        creationDate = media.asset.creationDate
        location = media.asset.location?.description
        duration = media.asset.duration
        modificationDate = media.asset.modificationDate
        sourceType = media.asset.sourceType.mediaDescription
        subType = media.asset.mediaSubtypes.mediaDescription
    }

    // MARK: - Comparable

    static func < (lhs: MediaMetaData, rhs: MediaMetaData) -> Bool {
        if let lhsDate = lhs.creationDate, let rhsDate = rhs.creationDate {
            lhsDate < rhsDate
        } else if lhs.creationDate != nil {
            false
        } else if rhs.creationDate != nil {
            true
        } else {
            lhs.fileName < rhs.fileName
        }
    }
}

// MARK: - PHAssetMediaType + Extensions

extension PHAssetMediaType {
    var mediaDescription: String? {
        switch self {
        case .unknown: "unknown"
        case .image: "image"
        case .video: "video"
        case .audio: "audio"
        default: nil
        }
    }
}

// MARK: - PHAssetMediaSubtype + Values

extension PHAssetMediaSubtype {
    var mediaDescription: String? {
        switch self {
        case .photoPanorama: "photoPanorama"
        case .photoHDR: "photoHDR"
        case .photoScreenshot: "photoScreenshot"
        case .photoLive: "photoLive"
        case .photoDepthEffect: "photoDepthEffect"
        case .spatialMedia: "spatialMedia"
        case .videoStreamed: "videoStreamed"
        case .videoHighFrameRate: "videoHighFrameRate"
        case .videoTimelapse: "videoTimelapse"
        case .videoCinematic: "videoCinematic"
        default: nil
        }
    }
}

// MARK: - PHAssetSourceType + Values

extension PHAssetSourceType {
    var mediaDescription: String? {
        switch self {
        case .typeUserLibrary: "typeUserLibrary"
        case .typeCloudShared: "typeCloudShared"
        case .typeiTunesSynced: "typeiTunesSynced"
        default: nil
        }
    }
}
