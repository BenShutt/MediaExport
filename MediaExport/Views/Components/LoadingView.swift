//
//  LoadingView.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.

//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .foregroundStyle(Color.appDarkGray)
    }
}
