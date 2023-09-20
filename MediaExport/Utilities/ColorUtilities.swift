//
//  ColorUtilities.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct ColorUtilities {

    private static let hexCharacters = "0123456789ABCDEF"

    static func mappedHexString(_ hexString: String, offset: Int) -> String {
        String(hexString.uppercased().map { character in
            hexCharacters.map(character, offset: offset)
        })
    }

    static func mappedColor(_ color: Color, offset: Int) -> Color {
        let mappedHexString = mappedHexString(color.hexString(), offset: offset)
        return Color(hexString: mappedHexString) ?? color
    }
}

// MARK: - Array + Extensions

private extension Collection where Element: Equatable {

    func map(_ element: Element, offset: Int) -> Element {
        guard let currentIndex = firstIndex(of: element) else { return element }
        if offset >= 0 {
            let maxIndex = index(endIndex, offsetBy: -offset)
            // endIndex is off the edge so strictly less than
            guard currentIndex < maxIndex else { return element }
        } else {
            let minIndex = index(startIndex, offsetBy: -offset)
            guard currentIndex >= minIndex else { return element }
        }
        let mappedIndex = index(currentIndex, offsetBy: offset)
        return self[mappedIndex]
    }
}
