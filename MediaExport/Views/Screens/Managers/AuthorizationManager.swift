//
//  AuthorizationManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Photos

@MainActor
struct AuthorizationManager {
    private static let accessLevel: PHAccessLevel = .readWrite

    static var isAuthorized: Bool {
        PHPhotoLibrary.authorizationStatus(for: accessLevel) == .authorized
    }

    static func requestAuthorization() async -> Bool {
        await withCheckedContinuation { continuation in
            PHPhotoLibrary.requestAuthorization(for: accessLevel) { _ in
                DispatchQueue.main.async {
                    continuation.resume(returning: isAuthorized)
                }
            }
        }
    }
}
