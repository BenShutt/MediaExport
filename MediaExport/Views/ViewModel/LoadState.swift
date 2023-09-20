//
//  LoadState.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

enum LoadState<Success> {

    case pending
    case loading
    case success([Success])
    case failure(Error)

    var isLoading: Bool {
        guard case .loading = self else { return false }
        return true
    }

    var title: LocalizedStringKey {
        return "TODO" // TODO!
    }

    var imageName: String? {
        switch self {
        case .pending: return "clock.fill"
        case .loading: return nil
        case .success: return "checkmark.circle.fill"
        case .failure: return "xmark.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .success: return .green
        case .failure: return .red
        default: return .accentColor
        }
    }
}