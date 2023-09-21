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

    /// The path of the URL components
    var endpoint: String { get }
}

// MARK: - Extensions

extension APIRequest {

    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "192.168.0.205"
        components.port = 8000
        components.path = endpoint
        components.queryItems = nil
        return components
    }
}
