//
//  MediaFileAPIRequest.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire
import DataRequest

protocol MediaFileAPIRequest: APIRequest {

    /// The media file to query
    var mediaFile: MediaFile { get }
}

// MARK: - Extensions

extension MediaFileAPIRequest {

    var additionalHeaders: HTTPHeaders {
        [
            HTTPHeader(name: "X-File-Name", value: mediaFile.fileName)
        ]
    }
}
