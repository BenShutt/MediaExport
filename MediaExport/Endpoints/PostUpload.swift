//
//  PostUpload.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire
import DataRequest

struct PostUpload: MediaFileAPIRequest, DataBody {

    let method: HTTPMethod = .post
    let endpoint = "/api/upload"
    var mediaFile: MediaFile

    var body: Data {
        get async throws {
            try await mediaFile.data()
        }
    }
}

// MARK: - Extensions

extension PostUpload {

    static func upload(mediaFile: MediaFile) async throws {
        let status = try await PostUpload(mediaFile: mediaFile).request().status
        guard status == 0 else { throw APIError.status(status) }
    }
}
