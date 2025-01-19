//
//  NavigationRoute.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/01/2025.
//

import SwiftUI

/// A navigation destination
@MainActor
enum NavigationRoute: Hashable {

    /// Push the assets screen
    case assets

    /// Push the resources screen
    case resources(AssetsMap)

    /// Push the status screen
    case status([MediaFile])

    /// Push the upload screen
    case upload([MediaFile])

    /// Map each route to its respective view
    @ViewBuilder var screen: some View {
        switch self {
        case .assets:
            AssetsScreen()
        case let .resources(assetsMap):
            ResourcesScreen(assetsMap: assetsMap)
        case let .status(mediaFiles):
            StatusScreen(mediaFiles: mediaFiles)
        case let .upload(mediaFiles):
            UploadScreen(mediaFiles: mediaFiles)
        }
    }
}

// MARK: - View + NavigationRoute

extension View {
    func navigateRoutes() -> some View {
        navigationDestination(for: NavigationRoute.self) { route in
            route.screen
        }
    }
}
