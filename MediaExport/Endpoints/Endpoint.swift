//
//  Endpoint.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import Alamofire
import DataRequest

// MARK: - Endpoint

protocol Endpoint: URLRequestMaker {

    var endpoint: String { get }
}

extension Endpoint {

    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "192.168.0.205"
        components.port = 8000
        components.path = endpoint
        components.queryItems = nil
        return components
    }

    func additionalHeaders(mediaFile: MediaFile) -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers.append(.acceptJSON)
        headers.append(HTTPHeader(name: "X-File-Name", value: mediaFile.fileName))
        return headers
    }
}

// MARK: - DecodableEndpoint

protocol DecodableEndpoint: Endpoint, DecodableRequest where ResponseBody == Status {}
