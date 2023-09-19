//
//  TmpScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI
import Photos

struct TmpScreen: View {

    @State private var state: LoadState<PHAsset> = .pending

    @MainActor func execute() async {
        state = .loading
        do {
            state = try await .success(PhotoLibrary.fetchAll())
        } catch {
            state = .failure(error)
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            if state.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if let imageName = state.imageName {
                Image(systemName: imageName)
                    .resizable()
                    .foregroundColor(state.color)
                    .frame(width: 60, height: 60)
            }

            Text(state.title)
                .font(.largeTitle)
                .foregroundColor(.black)

            Button {
                Task {
                    await execute()
                }
            } label: {
                Text("continue_button")
                    .font(.headline)
            }
            .disabled(state.isLoading)
        }
        .padding(20)
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
