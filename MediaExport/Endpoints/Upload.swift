//
//  Upload.swift
//  MediaExport
//
//  Created by Ben Shutt on 18/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation
import DataRequest

struct Upload: APIRequest, DataBody {
    
    let endpoint = "/api/upload"
    var mediaFile: MediaFile

    var body: Data {
        get throws {
            try Data(contentsOf: mediaFile.url)
        }
    }
}
