//
//  Status.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

struct Status: Decodable {
    let status: Int
}

// MARK: - StatusError

enum StatusError: Error {
    case status(Int)
}
