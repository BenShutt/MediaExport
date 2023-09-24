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

struct PostUpload: Endpoint {

    let method: HTTPMethod = .post
    let endpoint = "/api/upload"
    var mediaFile: MediaFile

    var additionalHeaders: HTTPHeaders {
        additionalHeaders(mediaFile: mediaFile)
    }
}

extension PostUpload {

    static func upload(mediaFile: MediaFile) async throws {
        try await AF.upload(mediaFile.data(), with: PostUpload(mediaFile: mediaFile))
            .decodeValue(Status.self)
            .validate()
    }
}
