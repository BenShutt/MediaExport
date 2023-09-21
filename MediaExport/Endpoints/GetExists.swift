//
//  GetExists.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

struct GetExists: MediaFileAPIRequest {

    let endpoint = "/api/exists"
    var mediaFile: MediaFile
}

// MARK: - Extensions

extension GetExists {

    static func exists(mediaFile: MediaFile) async throws -> Bool {
        let status = try await GetExists(mediaFile: mediaFile).request().status
        guard [0, 1].contains(status) else { throw APIError.status(status) }
        return status == 1
    }
}