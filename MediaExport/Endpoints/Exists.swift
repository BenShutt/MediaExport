//
//  Exists.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

struct Exists: APIRequest {

    let endpoint = "/api/exists"
    var mediaFile: MediaFile
}