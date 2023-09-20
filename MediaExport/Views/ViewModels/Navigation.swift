//
//  NavigationViewModel.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

// MARK: - NavigationRoute

enum NavigationRoute: Hashable {

    case resources
    case upload
}

// MARK: - NavigationViewModel

final class Navigation: ObservableObject {

    @Published var path = NavigationPath()

    func push(_ route: NavigationRoute) {
        path.append(route)
    }
}
