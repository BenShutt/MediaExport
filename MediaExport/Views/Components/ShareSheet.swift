//
//  ShareSheet.swift
//  MediaExport
//
//  Created by Ben Shutt on 25/01/2025.
//

import SwiftUI
import LinkPresentation

// TODO: Replace? OnDismiss is used on the sheet (which works for the dismiss gesture)
struct ShareSheet: UIViewControllerRepresentable {
    let items: [ActivityItemSource]
    var onCompletion: UIActivityViewController.CompletionWithItemsHandler?

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ShareSheet>
    ) -> UIActivityViewController {
        let viewController = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        viewController.completionWithItemsHandler = onCompletion
        return viewController
    }

    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: UIViewControllerRepresentableContext<ShareSheet>
    ) {
        // Do nothing
    }
}

// MARK: - ActivityItemSource

class ActivityItemSource: NSObject, UIActivityItemSource {
    var title: String
    var url: URL

    init(title: String, url: URL) {
        self.title = title
        self.url = url
    }

    func activityViewControllerPlaceholderItem(
        _ activityViewController: UIActivityViewController
    ) -> Any {
        url
    }

    func activityViewController(
        _ activityViewController: UIActivityViewController,
        itemForActivityType activityType: UIActivity.ActivityType?
    ) -> Any? {
        url
    }

    func activityViewController(
        _ activityViewController: UIActivityViewController,
        subjectForActivityType activityType: UIActivity.ActivityType?
    ) -> String {
        title
    }

    func activityViewControllerLinkMetadata(
        _ activityViewController: UIActivityViewController
    ) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = title
        metadata.originalURL = url
        metadata.url = metadata.originalURL
        return metadata
    }
}
