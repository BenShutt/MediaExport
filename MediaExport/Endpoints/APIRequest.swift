//
//  APIRequest.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire
import DataRequest

protocol APIRequest: JSONDataRequest where ResponseBody == Status {

    /// The media file to query
    var mediaFile: MediaFile { get }

    /// The path of the URL components
    var endpoint: String { get }
}

// MARK: - Extensions

extension APIRequest {

    var additionalHeaders: HTTPHeaders {
        HTTPHeaders([
            HTTPHeader(name: "X-File-Name", value: mediaFile.fileName)
        ])
    }

    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        components.port = 8000
        components.path = endpoint
        components.queryItems = nil
        return components
    }
}
