//
//  MetaDataManager.swift
//  MediaExport
//
//  Created by Ben Shutt on 25/01/2025.
//

import SwiftUI
import Utilities

@MainActor
final class MetaDataManager: ObservableObject {
    @Published private(set) var state: LoadState<URL> = .idle
    @Published var presentedSheetURL: JSONFileURL?
    private let jsonExport = JSONExport(fileName: "metadata.json")

    func load(media: [MediaFile]) async {
        guard case .idle = state else { return }
        state = .loading
        do {
            let metaData = await MediaMetaData.map(media: media)
            let url = try await jsonExport.export(metaData)
            state = .success(url)
            presentedSheetURL = JSONFileURL(url: url)
        } catch {
            state = .failure(error)
        }
    }

    func clean() async throws {
        state = .idle
        try await jsonExport.clean()
    }
}

// MARK: - MediaMetaData + Map

private extension MediaMetaData {
    static func map(media: [MediaFile]) async -> [MediaMetaData] {
        media
            .map { MediaMetaData(media: $0) }
            .sorted()
    }
}

// MARK: - JSONFileURL

struct JSONFileURL: Identifiable {
    let id = UUID()
    var url: URL

    var item: ActivityItemSource {
        .init(
            title: String(localized: "export_share_title"),
            url: url
        )
    }
}

// MARK: - JSONExport

private struct JSONExport {
    let directory: FileManager.SearchPathDirectory = .cachesDirectory
    let fileName: String

    private var fileURL: URL {
        get throws {
            try FileManager.default.url(
                for: directory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            .appending(path: fileName)
        }
    }

    func export(_ model: some Encodable) async throws -> URL {
        let url = try fileURL
        let data = try JSONEncoder.pretty.encode(model)
        try data.write(to: url, options: .atomic)
        return url
    }

    func clean() async throws {
        try FileManager.default.removeItem(at: fileURL)
    }
}
