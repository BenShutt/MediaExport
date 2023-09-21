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
            UploadContentView(uploadManager: uploadManager)
        }
        .modifier(
            StickyButton(
                key: "done_button",
                backgroundColor: .appGreen,
                isEnabled: !uploadManager.loadState.isLoading,
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

// MARK: - UploadContentView

private struct UploadContentView: View {

    @ObservedObject var uploadManager: UploadManager

    private var progressString: LocalizedStringKey? {
        guard let state = uploadManager.syncState else { return nil }
        switch state {
        case let .checking(mediaFile):
            return "checking \(mediaFile.fileName)"
        case let .uploading(mediaFile):
            return "uploading \(mediaFile.fileName)"
        }
    }

    var body: some View {
        switch uploadManager.loadState {
        case .idle: EmptyView()

        case .loading:
            BarProgressView(
                value: uploadManager.value,
                total: uploadManager.total
            )

            LoadingView()
                .padding(.top, .vPadding)

        case .success:
            SuccessView()
                .frame(size: 200)

        case .failure(let error):
            Text(verbatim: error.localizedDescription)
                .body(textColor: .appRed)
        }
    }
}

// MARK: - Preview

#Preview {
    UploadScreen(mediaFiles: [])
        .environmentObject(Navigation())
}
