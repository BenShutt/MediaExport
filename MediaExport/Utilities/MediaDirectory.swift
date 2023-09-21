//
//  MediaDirectory.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

/// Legacy SPM executable client-side logic that used 'swift-argument-parser'
@available(*, deprecated, message: "Used to be used in SPM executable")
struct MediaDirectory {

    /// A media file
    struct File {
        var url: URL
        var fileType: FileType
    }

    /// A type of media file
    enum FileType: String, CaseIterable {
        case jpeg // Image
        case png // Image
        case heic // Image
        case mov // Video
        case mp4 // Video
    }

    /// Map a `URL` to an optional type
    typealias Operation<Target> = (URL) -> Target?

    /// Directory path (e.g. command line argument)
    var directory: String

    /// URL of the directory
    var directoryURL: URL {
        URL(filePath: (directory as NSString).expandingTildeInPath)
    }

    /// Enumerate the files in `url`
    /// - Parameter operation: Operation to execute on each URL
    /// - Returns: Outputted files
    func forEach<Target>(operation: Operation<Target>) throws -> [Target] {
        try FileManager.default.contentsOfDirectory(
            at: directoryURL,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles]
        ).compactMap { url in
            operation(url)
        }
    }

    /// Get the media files printing when a file is not a valid media
    /// - Returns: Valid media files
    func validate() throws -> [File] {
        let files = try forEach { url in
            let file = File(url: url)
            if file == nil {
                print("Unsupported media URL: '\(url)'")
            }
            return file
        }

        if files.isEmpty {
            print("No media found in: '\(directoryURL)'")
        } else {
            print("\(files.count) media file(s) found in: '\(directoryURL)'")
        }

        return files
    }
}

// MARK: - MediaDirectory.File + Extensions

@available(*, deprecated, message: "Used to be used in SPM executable")
extension MediaDirectory.File {

    var data: Data {
        get throws {
            try Data(contentsOf: url)
        }
    }

    init?(url: URL) {
        let pathExtension = url.pathExtension.lowercased()
        let fileType = MediaDirectory.FileType.allCases.first { fileType in
            fileType.pathExtensions.contains(pathExtension)
        }
        guard let fileType else { return nil }
        self.url = url
        self.fileType = fileType
    }
}

// MARK: - MediaDirectory.FileType + Extensions

@available(*, deprecated, message: "Used to be used in SPM executable")
private extension MediaDirectory.FileType {

    var pathExtensions: Set<String> {
        var set = Set([rawValue])
        guard case .jpeg = self else { return set }
        set.insert("jpg")
        return set
    }
}
