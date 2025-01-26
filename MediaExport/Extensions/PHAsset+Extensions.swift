//
//  PHAsset+Extensions.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//

import Foundation
import Photos
import Utilities

// MARK: - Resources

extension PHAsset {

    /// - Warning: Assumes each PHAsset object references at least one resource.
    private var firstResource: PHAssetResource {
        get throws {
            let resources = PHAssetResource.assetResources(for: self)
            return try resources.first ?! PHAssetError.firstResource
        }
    }

    /// - Warning: Assumes the first resource is enough.
    var originalFilename: String {
        get throws {
            try firstResource.originalFilename
        }
    }
}

// MARK: - PHAssetError

enum PHAssetError: Error {
    case firstResource
}
