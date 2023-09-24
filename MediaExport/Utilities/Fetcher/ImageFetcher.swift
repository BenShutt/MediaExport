//
//  ImageFetcher.swift
//  MediaExport
//
//  Created by Ben Shutt on 24/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Photos
import CubeFoundation

struct ImageFetcher {

    private static var options: PHImageRequestOptions {
        let options = PHImageRequestOptions()
        options.version = .current
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .none
        if #available(iOS 17, *) {
            options.allowSecondaryDegradedImage = false
        }
        return options
    }

    static func data(for asset: PHAsset) async throws -> Data {
        try await withCheckedContinuation { continuation in
            PHImageManager().requestImageDataAndOrientation(
                for: asset,
                options: options
            ) { data, _, _, _ in
                continuation.resume(returning: Result(catching: {
                    try data ?! ImageFetcherError.data
                }))
            }
        }.get()
    }
}

// MARK: - ImageFetcherError

enum ImageFetcherError: Error {

    case data
}
