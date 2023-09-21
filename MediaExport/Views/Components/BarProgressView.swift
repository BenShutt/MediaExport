//
//  BarProgressView.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct BarProgressView<Value: BinaryFloatingPoint>: View {

    var value: Value
    var total: Value
    var progressString: LocalizedStringKey?

    var body: some View {
        VStack(spacing: .vPaddingSmall) {
            ProgressView(value: value, total: total)
                .progressViewStyle(BarProgressViewStyle(height: 30))

            if let progressString {
                Text(progressString)
                    .caption()
            }
        }
    }
}

// MARK: - BarProgressViewStyle

private struct BarProgressViewStyle: ProgressViewStyle {

    var height: CGFloat
    var backgroundColor: Color = .appBlack.opacity(0.15)
    var progressColor: Color = .appGreen

    private func progress(_ configuration: Configuration) -> CGFloat {
        configuration.fractionCompleted ?? 0
    }

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            backgroundColor
                .frame(width: geometry.size.width)
                .overlay(alignment: .leading) {
                    progressColor
                        .frame(width: geometry.size.width * progress(configuration))
                }
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview

#Preview {
    BarProgressView(
        value: 1,
        total: 3,
        progressString: "uploading \("file.txt")"
    )
}
