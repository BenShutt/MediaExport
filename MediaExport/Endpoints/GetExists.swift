//
//  GetExists.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire

struct GetExists: Endpoint {
    let endpoint = "/api/exists"
    let mediaFile: MediaFile

    var headers: HTTPHeaders {
        headers(mediaFile: mediaFile)
    }

    func requestValue() async throws -> Bool {
        let status = try await request().status
        guard status == 0 || status == 1 else {
            throw StatusError.status(status)
        }
        return status == 1
    }
}
