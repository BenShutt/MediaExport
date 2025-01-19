//
//  ColorUtilities.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.

//

import SwiftUI
import ColorUtilities

struct ColorUtilities {
    private static let hexCharacters = "0123456789ABCDEF"

    static func mappedHexString(_ hexString: String, offset: Int) -> String {
        String(hexString.uppercased().map { character in
            hexCharacters.map(character, offset: offset)
        })
    }

    static func mappedColor(_ color: Color, offset: Int) -> Color {
        let mappedHexString = mappedHexString(color.hex(), offset: offset)
        return Color(hex: mappedHexString) ?? color
    }
}

// MARK: - Array + Extensions

private extension Collection where Element: Equatable {
    func map(_ element: Element, offset: Int) -> Element {
        guard let currentIndex = firstIndex(of: element) else { return element }
        if offset >= 0 {
            let maxIndex = index(endIndex, offsetBy: -offset)
            // endIndex is "past the end" so we strictly less than here
            guard currentIndex < maxIndex else { return element }
        } else {
            let minIndex = index(startIndex, offsetBy: -offset)
            guard currentIndex >= minIndex else { return element }
        }
        let mappedIndex = index(currentIndex, offsetBy: offset)
        return self[mappedIndex]
    }
}
