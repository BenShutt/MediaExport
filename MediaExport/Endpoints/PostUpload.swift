//
//  PostUpload.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//

import Foundation
import Alamofire
import DataRequest

struct PostUpload: Endpoint {
    let method: HTTPMethod = .post
    let endpoint = "/api/upload"
    let mediaFile: MediaFile

    var headers: HTTPHeaders {
        headers(mediaFile: mediaFile)
    }

    @discardableResult
    func upload() async throws -> Status {
        try await session
            .upload(
                mediaFile.loadData(),
                with: self,
                interceptor: interceptor
            )
            .decodeValue(
                ResponseBody.self,
                validate: validate,
                decoder: decoder
            )
    }
}
