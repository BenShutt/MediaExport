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

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            AssetsScreen()
                .onAppear {
                    PhotoLibrary.requestAuthorization()
                }
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
