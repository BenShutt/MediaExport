//
//  ContentView.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//

import SwiftUI
import Photos

struct ContentView: View {
    var body: some View {
        RootNavigationStack {
            if AuthorizationManager().isAuthorized {
                AssetsScreen()
            } else {
                AuthorizationScreen()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
