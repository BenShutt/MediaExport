//
//  SuccessView.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.

//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.appGreen)
            .accessibilityHidden(true)
    }
}

#Preview {
    SuccessView()
        .frame(width: 250, height: 250)
}
