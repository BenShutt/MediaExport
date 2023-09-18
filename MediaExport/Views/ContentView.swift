//
//  ContentView.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var state: LoadState = .pending

    @MainActor func execute() async {
        state = .loading
        do {
            state = try await .success(PhotoLibrary.load())
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

            Text(verbatim: state.title)
                .font(.largeTitle)
                .foregroundColor(.black)

            Button {
                Task {
                    await execute()
                }
            } label: {
                Text(verbatim: .execute)
                    .font(.headline)
            }
            .disabled(state.isLoading)
        }
        .padding(20)
    }
}

// MARK: - PreviewProvider

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
