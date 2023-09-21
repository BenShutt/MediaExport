//
//  PHAsset+Extensions.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Photos

// MARK: - Resources

extension PHAsset {

    var firstResource: PHAssetResource {
        get throws {
            let resource = PHAssetResource.assetResources(for: self).first
            guard let resource else { throw PHAssetError.firstResource }
            return resource
        }
    }

    var originalFilename: String {
        get throws {
            try firstResource.originalFilename
        }
    }

    var fileSize: Int64 {
        get throws {
            let long = try firstResource.value(forKey: "fileSize") as? CLong
            guard let long else { throw PHAssetError.fileSize }
            return Int64(bitPattern: UInt64(long))
        }
    }
}

// MARK: - Data

extension PHAsset {

    func data() async throws -> Data {
        switch mediaType {
        case .image: return try await imageData()
        case .video: return try await videoData()
        default: throw PHAssetError.data
        }
    }

    private func imageData() async throws -> Data {
        let data = await withCheckedContinuation { continuation in
            PHCachingImageManager().requestImageDataAndOrientation(
                for: self,
                options: PHImageRequestOptions()
            ) { data, _, _, _ in
                continuation.resume(returning: data)
            }
        }
        guard let data else { throw PHAssetError.imageData }
        return data
    }

    private func videoData() async throws -> Data {
        let avAsset = await withCheckedContinuation { continuation in
            PHCachingImageManager().requestAVAsset(
                forVideo: self,
                options: PHVideoRequestOptions()
            ) { avAsset, _, _ in
                continuation.resume(returning: avAsset)
            }
        }
        let avURLAsset = avAsset as? AVURLAsset
        guard let avURLAsset else { throw PHAssetError.videoData }
        return try Data(contentsOf: avURLAsset.url)
    }
}

// MARK: - PHAssetError

enum PHAssetError: Error {

    case firstResource
    case fileSize

    case data
    case imageData
    case videoData
}
