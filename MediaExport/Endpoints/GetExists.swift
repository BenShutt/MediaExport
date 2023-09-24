//
//  GetExists.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

struct GetExists: DecodableEndpoint {

    let endpoint = "/api/exists"
    var mediaFile: MediaFile

    var additionalHeaders: HTTPHeaders {
        additionalHeaders(mediaFile: mediaFile)
    }
}

// MARK: - Extensions

extension GetExists {

    static func request(mediaFile: MediaFile) async throws -> Bool {
        let status = try await GetExists(mediaFile: mediaFile).request()
        try status.validate { status in [0, 1].contains(status) }
        return status.status == 1
    }
}
