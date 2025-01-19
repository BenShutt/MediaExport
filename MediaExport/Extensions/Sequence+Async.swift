//
//  Sequence+Async.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/01/2025.
//  Copyright © 2025 Ben Shutt. All rights reserved.
//

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()
        for element in self {
            try await values.append(transform(element))
        }
        return values
    }

    func asyncFlatMap<T>(
        _ transform: (Element) async throws -> [T]
    ) async rethrows -> [T] {
        var values = [T]()
        for element in self {
            try await values.append(contentsOf: transform(element))
        }
        return values
    }

    func asyncReduce<Result>(
        _ initialResult: Result,
        _ nextPartialResult: ((Result, Element) async throws -> Result)
    ) async rethrows -> Result {
        var result = initialResult
        for element in self {
            result = try await nextPartialResult(result, element)
        }
        return result
    }
}
