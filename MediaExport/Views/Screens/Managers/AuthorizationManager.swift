//
//  AuthorizationManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//

import Foundation
import Photos

@MainActor
protocol PhotoAuthorization: Sendable {
    func checkAuthorized() throws
}

// MARK: - AuthorizationManager

struct AuthorizationManager: PhotoAuthorization {
    let accessLevel: PHAccessLevel = .readWrite

    func checkAuthorized() throws {
        guard isAuthorized else { throw AssetsManagerError.authorization }
    }

    var isAuthorized: Bool {
        PHPhotoLibrary.authorizationStatus(for: accessLevel) == .authorized
    }

    func requestAuthorization() async -> Bool {
        await PHPhotoLibrary.requestAuthorization(for: accessLevel)
        return isAuthorized
    }
}
