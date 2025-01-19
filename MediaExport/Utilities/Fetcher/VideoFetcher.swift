//
//  VideoFetcher.swift
//  MediaExport
//
//  Created by Ben Shutt on 24/09/2023.

//

import Foundation
import Photos
import Utilities

@MainActor
struct VideoFetcher {
    private static let options = {
        let options = PHVideoRequestOptions()
        options.version = .current
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        return options
    }()

    static func data(for mediaFile: MediaFile) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            PHImageManager.shared.requestExportSession(
                forVideo: mediaFile.asset,
                options: options,
                exportPreset: AVAssetExportPresetHighestQuality
            ) { session, info in
                if let session {
                    session.export(fileName: mediaFile.fileName) { result in
                        continuation.resume(with: result)
                    }
                } else if let error = info?[PHImageErrorKey] as? Error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: VideoFetcherError.session)
                }
            }
        }
    }
}

// MARK: - AVAssetExportSession + Extensions

extension AVAssetExportSession {
    // Needed so we do not send AVAssetExportSession
    @MainActor
    func export(
        fileName: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        Task {
            do {
                let data = try await export(fileName: fileName)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }

    // swiftlint:disable cyclomatic_complexity
    private func fileType(for fileName: String) throws -> AVFileType {
        let pathExtension = URL(filePath: fileName).pathExtension
        return switch pathExtension.lowercased() {
        case "mov": .mov
        case "mp4": .mp4
        case "m4v": .m4v
        case "m4a": .m4a
        case "caf": .caf
        case "wav": .wav
        case "mp3": .mp3
        case "jpg": .jpg
        case "heic": .heic
        case "tif": .tif
        default: throw VideoFetcherError.fileType(pathExtension) // Not all are supported
        }
    }
    // swiftlint:enable cyclomatic_complexity

    private func export(fileName: String) async throws -> Data {
        let url = FileManager.default
            .temporaryDirectory
            .appending(path: fileName)
        defer {
            try? FileManager.default.removeItem(at: url)
        }
        try await export(
            to: url,
            as: fileType(for: fileName)
        )
        return try Data(contentsOf: url) // Video is loaded into memory...
    }
}

// MARK: - VideoFetcherError

enum VideoFetcherError: Error, CustomStringConvertible {
    case session
    case fileType(String)

    var description: String {
        switch self {
        case .session: "Failed to fetch video session"
        case let .fileType(fileType): "Unsupported file type: \(fileType)"
        }
    }
}
