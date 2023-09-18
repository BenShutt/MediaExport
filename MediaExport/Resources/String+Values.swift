//
//  String+Values.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

extension String {

    static let execute = "Execute"

    struct LoadState {

        static let pending = "Tap to start"
        static let loading = "Loading..."

        static func success(count: Int) -> String {
            "Success: \(count)"
        }

        static func failure(message: String) -> String {
            "Failure: \(message)"
        }
    }
}
