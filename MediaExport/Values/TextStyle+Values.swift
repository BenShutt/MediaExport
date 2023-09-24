//
//  TextStyle+Values.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

// MARK: - TextStyle + Values

extension TextStyle {

    static let badge = TextStyle(.system, weight: .heavy, size: 45, lineHeight: 47)
    static let body = TextStyle(.system, weight: .regular, size: 20, lineHeight: 22)
    static let caption = TextStyle(.system, weight: .semibold, size: 18, lineHeight: 20)

    static let button = TextStyle(.system, weight: .heavy, size: 18, lineHeight: 22)
}

// MARK: - Text + TextStyles

extension Text {

    func badge(textColor: Color = .appBlack) -> some View {
        style(.badge)
            .foregroundStyle(textColor)
    }

    func body(textColor: Color = .appDarkGray) -> some View {
        style(.body)
            .foregroundStyle(textColor)
    }

    func caption(textColor: Color = .appDarkGray) -> some View {
        style(.caption)
            .foregroundStyle(textColor)
    }

    func button(textColor: Color = .appDarkGray) -> some View {
        style(.button)
            .foregroundStyle(textColor)
    }
}
