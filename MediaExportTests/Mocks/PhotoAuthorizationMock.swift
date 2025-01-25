//
//  PhotoAuthorizationMock.swift
//  MediaExport
//
//  Created by Ben Shutt on 25/01/2025.
//

@testable import MediaExport

struct PhotoAuthorizationMock: PhotoAuthorization {
    func checkAuthorized() throws {
        // do nothing
    }
}
