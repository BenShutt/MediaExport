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

    static let badge = TextStyle(.system, weight: .heavy, size: 45, lineHeight: 45)
    static let body = TextStyle(.system, weight: .regular, size: 20, lineHeight: 22)
    static let button = TextStyle(.system, weight: .heavy, size: 18, lineHeight: 22)
    static let caption = TextStyle(.system, weight: .semibold, size: 18, lineHeight: 20)
}

// MARK: - Text + TextStyles

extension Text {

    func badge() -> some View {
        self.style(.badge)
            .foregroundStyle(Color.appBlack)
            .lineLimit(1)
    }

    func body() -> some View {
        self.style(.body)
            .foregroundStyle(Color.appDarkGray)
    }

    func caption() -> some View {
        self.style(.caption)
            .foregroundStyle(Color.appDarkGray)
    }
}
