//
//  ContentView.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI
import Photos

struct ContentView: View {

    /// Storage of the `Navigation` environment instance
    @StateObject private var navigation = Navigation()

    var body: some View {
        NavigationStack(path: $navigation.path) {
            AuthorizationScreen()
                .navigate()
        }
        .environmentObject(navigation)
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
