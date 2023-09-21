//
//  GetStatus.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

struct GetStatus: APIRequest {

    let endpoint = "/api/status"
}

// MARK: - Extensions

extension GetStatus {

    @discardableResult
    static func validate() async throws -> Int {
        try await GetStatus().request().validate()
    }
}
