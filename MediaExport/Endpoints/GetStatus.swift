//
//  GetStatus.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

struct GetStatus: Endpoint {
    let endpoint = "/api/status"

    func requestValue() async throws -> Int {
        let status = try await request().status
        guard status == 0 else { throw StatusError.status(status) }
        return status
    }
}
