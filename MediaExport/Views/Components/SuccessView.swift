//
//  SuccessView.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct SuccessView: View {

    var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.appGreen)
    }
}

#Preview {
    SuccessView()
        .frame(size: 250)
}
