//
//  VideoFetcher.swift
//  MediaExport
//
//  Created by Ben Shutt on 24/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Photos
import Utilities

struct VideoFetcher {
    private static func fileType(
        for fileName: String
    ) throws -> AVFileType {
        let pathExtension = URL(filePath: fileName).pathExtension.lowercased()
        switch pathExtension {
        case "mov": return .mov
        case "mp4": return .mp4
        case "m4v": return .m4v
        case "m4a": return .m4a
        case "caf": return .caf
        case "wav": return .wav
        case "mp3": return .mp3
        case "jpg": return .jpg
        case "heic": return .heic
        case "tif": return .tif
        default: throw VideoFetcherError.fileType(pathExtension) // Not all are supported
        }
    }

    private static func export(
        session: AVAssetExportSession,
        fileName: String
    ) async throws -> Data {
        let url = FileManager.default
            .temporaryDirectory
            .appending(path: fileName)
        defer {
            try? FileManager.default.removeItem(at: url)
        }
        session.outputURL = url
        session.outputFileType = try fileType(for: fileName)
        await session.export()
        return try Data(contentsOf: url) // Video is loaded into memory...
    }

    private static var options: PHVideoRequestOptions {
        let options = PHVideoRequestOptions()
        options.version = .current
        options.deliveryMode = .highQualityFormat
        // options.isNetworkAccessAllowed = true
        return options
    }

    static func data(for mediaFile: MediaFile) async throws -> Data {
        let session = try await withCheckedThrowingContinuation { continuation in
            PHImageManager.shared.requestExportSession(
                forVideo: mediaFile.asset,
                options: options,
                exportPreset: AVAssetExportPresetHighestQuality
            ) { session, info in
                if let session {
                    continuation.resume(returning: session)
                } else if let error = info?[PHImageErrorKey] as? Error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: VideoFetcherError.session)
                }
            }
        }
        return try await export(
            session: session,
            fileName: mediaFile.fileName
        )
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
