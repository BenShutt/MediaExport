//
//  TextStyle+Values.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//

import SwiftUI

extension View {
    func badge(textColor: Color = .appBlack) -> some View {
        styledText(
            font: .system(size: 45, weight: .heavy),
            textAlignment: .leading,
            foregroundColor: textColor
        )
    }

    func body(textColor: Color = .appDarkGray) -> some View {
        styledText(
            font: .system(size: 20, weight: .regular),
            textAlignment: .leading,
            foregroundColor: textColor
        )
    }

    func caption(textColor: Color = .appDarkGray) -> some View {
        styledText(
            font: .system(size: 18, weight: .semibold),
            textAlignment: .leading,
            foregroundColor: textColor
        )
    }

    func button(textColor: Color = .appDarkGray) -> some View {
        styledText(
            font: .system(size: 18, weight: .heavy),
            textAlignment: .leading,
            foregroundColor: textColor
        )
    }
}
