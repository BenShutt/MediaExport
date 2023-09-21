//
//  AuthorizationManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Photos

struct AuthorizationManager {

    private static let accessLevel: PHAccessLevel = .readWrite

    static func isAuthorized() -> Bool {
        PHPhotoLibrary.authorizationStatus(for: accessLevel) == .authorized
    }

    static func requestAuthorization(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: accessLevel) { _ in
            DispatchQueue.main.async {
                completion(isAuthorized())
            }
        }
    }
}
