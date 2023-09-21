//
//  Status.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

struct Status: Decodable {

    var status: Int

    @discardableResult
    func validate() throws -> Int {
        try validate { status in status == 0 }
    }

    @discardableResult
    func validate(closure: (Int) -> Bool) throws -> Int {
        guard closure(status) else { throw StatusError.status(status) }
        return status
    }
}

// MARK: - StatusError

enum StatusError: Error {

    case status(Int)
}
