//
//  Upload.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import DataRequest

struct Upload: APIRequest, DataBody {

    let endpoint = "/api/upload"
    var mediaFile: MediaFile

    var body: Data {
        get async throws {
            try await mediaFile.data()
        }
    }
}

// MARK: - Extensions

extension Upload {

    static func upload(mediaFile: MediaFile) async throws {
        let status = try await Upload(mediaFile: mediaFile).request().status
        guard status == 0 else { throw APIError.status(status) }
    }
}
