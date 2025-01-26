//
//  ImageFetcher.swift
//  MediaExport
//
//  Created by Ben Shutt on 24/09/2023.
//

import Foundation
import Photos
import Utilities

@MainActor
struct ImageFetcher {
    private static let options = {
        let options = PHImageRequestOptions()
        options.version = .current
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .none
        options.isNetworkAccessAllowed = true
        options.allowSecondaryDegradedImage = false
        return options
    }()

    static func data(for asset: PHAsset) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            PHImageManager.shared.requestImageDataAndOrientation(
                for: asset,
                options: options
            ) { data, _, _, keyValues in
                if let data {
                    continuation.resume(returning: data)
                } else if let error = keyValues?[PHImageErrorKey] as? Error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: ImageFetcherError.data)
                }
            }
        }
    }
}

// MARK: - ImageFetcherError

enum ImageFetcherError: Error, CustomStringConvertible {
    case data

    var description: String {
        switch self {
        case .data: "Failed to fetch image data"
        }
    }
}
