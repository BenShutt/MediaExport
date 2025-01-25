//
//  UploadScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//

import SwiftUI

struct UploadScreen: View {
    @Environment(\.popToRoot) private var popToRoot
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
                isEnabled: uploadManager.loadState.isFinished,
                onTap: onContinue
            )
        )
        .task {
            await uploadManager.sync()
        }
    }

    private func onContinue() {
        guard uploadManager.loadState.isFinished else { return }
        popToRoot()
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
        case .idle:
            EmptyView()

        case .loading:
            BarProgressView(
                value: uploadManager.value,
                total: uploadManager.total,
                progressString: progressString
            )

            LoadingView()
                .padding(.top, .vPadding)

        case .success:
            SuccessView()
                .frame(width: 250, height: 250)

        case let .failure(error):
            Text(verbatim: "\(error)")
                .body(textColor: .appRed)
        }
    }
}

// MARK: - Preview

#Preview {
    UploadScreen(mediaFiles: [])
}
