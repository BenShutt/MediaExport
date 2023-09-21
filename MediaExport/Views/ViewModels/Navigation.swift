//
//  NavigationViewModel.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

// MARK: - NavigationRoute

/// A navigation destination
enum NavigationRoute: Hashable {

    /// Push the assets screen
    case assets

    /// Push the resources screen
    case resources
}

// MARK: - Navigation

/// View model for navigation
final class Navigation: ObservableObject {

    /// `NavigationPath`
    @Published var path = NavigationPath()

    /// Push `route` on `path`
    /// - Parameter route: `NavigationRoute`
    func push(_ route: NavigationRoute) {
        path.append(route)
    }
}

// MARK: - View + NavigationRoute

extension View {

    /// Add navigation destination handler to view
    func navigate() -> some View {
        navigationDestination(for: NavigationRoute.self) { route in
            switch route {
            case .assets:
                AssetsScreen()
            case .resources:
                ResourcesScreen()
            }
        }
    }
}
