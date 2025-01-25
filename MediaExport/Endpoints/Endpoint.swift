//
//  Endpoint.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//

import Foundation
import Alamofire
import DataRequest

protocol Endpoint: DecodableRequest where ResponseBody == Status {
    var endpoint: String { get }
    var timeoutInterval: TimeInterval { get }
}

extension Endpoint {
    var timeoutInterval: TimeInterval {
        5
    }

    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "192.168.1.109"
        components.port = 8000
        components.path = endpoint
        components.queryItems = nil
        return components
    }

    func headers(mediaFile: MediaFile) -> HTTPHeaders {
        var headers: HTTPHeaders = .default
        headers.append(.acceptJSON)
        headers.append(HTTPHeader(
            name: "X-File-Name",
            value: mediaFile.fileName
        ))
        return headers
    }

    func asURLRequest() throws -> URLRequest {
        var urlRequest = try urlRequest
        urlRequest.timeoutInterval = timeoutInterval
        return urlRequest
    }
}
