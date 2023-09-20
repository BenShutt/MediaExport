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

    static let header = TextStyle(.system, weight: .heavy, size: 36, lineHeight: 40)
    static let body = TextStyle(.system, weight: .regular, size: 20, lineHeight: 22)
    static let button = TextStyle(.system, weight: .heavy, size: 18, lineHeight: 22)
    static let header2 = TextStyle(.system, weight: .bold, size: 20, lineHeight: 22)
}

// MARK: - Text + TextStyles

extension Text {

    func header() -> some View {
        self.style(.header)
            .foregroundStyle(Color.appBlack)
    }

    func body() -> some View {
        self.style(.body)
            .foregroundStyle(Color.appDarkGray)
    }

    func header2() -> some View {
        self.style(.header2)
            .foregroundStyle(Color.appDarkGray)
    }
}
