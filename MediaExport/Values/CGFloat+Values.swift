//
//  CGFloat+Values.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

// MARK: - CGFloat + Values

extension CGFloat {

    static let hPadding: CGFloat = 20
    static let vPadding: CGFloat = 16

    static let hPaddingLarge: CGFloat = 40
    static let vPaddingLarge: CGFloat = 32

    static let corners: CGFloat = 10
}

// MARK: - EdgeInsets + Values

extension EdgeInsets {

    static let padding = EdgeInsets(
        top: .vPadding,
        leading: .hPadding,
        bottom: .vPadding,
        trailing: .hPadding
    )

    static let paddingLarge = EdgeInsets(
        top: .vPaddingLarge,
        leading: .hPaddingLarge,
        bottom: .vPaddingLarge,
        trailing: .hPaddingLarge
    )
}
