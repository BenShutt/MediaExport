//
//  Status.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.

//

import Foundation

struct Status: Decodable {
    let status: Int
}

// MARK: - StatusError

enum StatusError: Error {
    case status(Int)
}
