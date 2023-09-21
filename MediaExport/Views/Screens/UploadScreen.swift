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
        Screen(
            title: "upload_title",
            subtitle: "upload_subtitle"
        ) {
            ProgressView(
                value: uploadManager.value,
                total: uploadManager.total,
                label: {},
                currentValueLabel: {
                    if let progressString {
                        Text(progressString)
                            .caption()
                    }
                }
            )
            .tint(.appGreen)
            .background(.appBlack)
            .frame(minWidth: .infinity)
            .padding(.top, .vPaddingLarge)
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

// MARK: - Preview

#Preview {
    UploadScreen(mediaFiles: [])
        .environmentObject(Navigation())
}
