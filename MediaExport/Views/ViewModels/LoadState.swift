//
//  LoadState.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

enum LoadState<Success> {

    case idle
    case loading
    case success(Success)
    case failure(Error)

    var isLoading: Bool {
        guard case .loading = self else { return false }
        return true
    }

    var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }
}
