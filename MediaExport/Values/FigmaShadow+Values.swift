//
//  FigmaShadow+Values.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import CubeFoundationSwiftUI

extension FigmaShadow {

    static let sticky = FigmaShadow(
        x: 0,
        y: 2,
        blur: 15 * 2,
        color: .appDarkGray.opacity(0.15)
    )
}
