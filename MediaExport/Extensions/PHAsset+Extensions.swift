//
//  PHAsset+Extensions.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Photos
import CubeFoundation

// MARK: - Resources

extension PHAsset {

    /// - Warning: Each PHAsset object references one or *more* resources.
    private var firstResource: PHAssetResource {
        get throws {
            let resources = PHAssetResource.assetResources(for: self)
            return try resources.first ?! PHAssetError.firstResource
        }
    }

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
