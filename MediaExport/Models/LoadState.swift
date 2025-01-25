//
//  LoadState.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
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

    var success: Success? {
        guard case .success(let value) = self else { return nil }
        return value
    }

    var isSuccess: Bool {
        success != nil
    }

    var isFinished: Bool {
        switch self {
        case .idle, .loading: false
        case .success, .failure: true
        }
    }
}
