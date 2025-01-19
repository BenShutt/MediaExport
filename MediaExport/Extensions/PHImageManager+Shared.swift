//
//  PHImageManager+Shared.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/01/2025.
//

import Photos

@MainActor
extension PHImageManager {
    static let shared = PHImageManager()
}
