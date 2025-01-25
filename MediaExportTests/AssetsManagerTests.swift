//
//  AssetsManagerTests.swift
//  MediaExport
//
//  Created by Ben Shutt on 24/01/2025.
//

import Testing
@testable import MediaExport

@MainActor
@Suite
struct AssetsManagerTests {
    @Test func fetchAll() async {
        let sut = AssetsManager(photoAuthorization: PhotoAuthorizationMock())
        await sut.load()
        guard case .success(let count) = sut.state else {
            Issue.record("Invalid state \(sut.state)")
            return
        }
    }
}
