//
//  ContentView.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//

import SwiftUI
import Photos

struct ContentView: View {
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
