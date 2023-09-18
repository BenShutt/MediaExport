//
//  PhotoLibrary.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Photos

struct File {
    var mediaType: PHAssetMediaType
}

final class PhotoLibrary {

    static func requestAuthorization() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { _ in }
    }

    static var mediaTypes: [PHAssetMediaType] {
        [.image, .video, .audio, .unknown]
    }

    static func load() async throws -> [File] {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        guard status == .authorized else { throw PhotoLibraryError.authorization }

        let images = PHAsset.fetch(with: .image)
        let videos = PHAsset.fetch(with: .video)
        let audios = PHAsset.fetch(with: .audio)
        let unknowns = PHAsset.fetch(with: .unknown)

        print("Images count = \(images.count)")
        print("Videos count = \(videos.count)")
        print("Audios count = \(audios.count)")
        print("Unknowns count = \(unknowns.count)")

        let maxImageSize = try await images.maxSize()
        let maxVideoSize = try await videos.maxSize()
        let maxSize = max(maxImageSize, maxVideoSize)

        let formatter: ByteCountFormatter = ByteCountFormatter()
        formatter.countStyle = .binary
        let formattedSize = formatter.string(fromByteCount: maxSize)
        print("Max size: \(formattedSize)")

        return []
    }
}

// MARK: - PhotoLibraryError

enum PhotoLibraryError: Error {

    case authorization
}
