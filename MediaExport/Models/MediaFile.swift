//
//  MediaFile.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Photos

struct MediaFile {

    var fileName: String
    var fileSize: CGFloat
    var asset: PHAsset

    var mediaType: PHAssetMediaType {
        asset.mediaType
    }

    func data() async throws -> Data {
        try await asset.data()
    }
}
