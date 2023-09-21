//
//  UploadScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct UploadScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var uploadManager: UploadManager

    init(mediaFiles: [MediaFile]) {
        _uploadManager = .init(wrappedValue: .init(mediaFiles: mediaFiles))
    }

    var body: some View {
        Screen(
            title: "upload_title",
            subtitle: "upload_subtitle"
        ) {
            EmptyView() // TODO
                .padding(.top, .vPaddingLarge)
        }
        .modifier(
            StickyButton(
                key: "continue_button",
                backgroundColor: .appGreen,
                isEnabled: !uploadManager.state.isLoading,
                onTap: { onContinue() }
            )
        )
        .onAppear {
            uploadManager.sync()
        }
    }

    private func onContinue() {
        navigation.popToRoot()
    }
}

// MARK: - Preview

#Preview {
    UploadScreen(mediaFiles: [])
        .environmentObject(Navigation())
}
