//
//  LoadStateView.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.

//

import SwiftUI

struct LoadStateView<Success, Content: View>: View {
    var state: LoadState<Success>
    @ViewBuilder var content: (Success) -> Content

    var body: some View {
        switch state {
        case .idle:
            EmptyView()
        case .loading:
            LoadingView()
        case let .success(success):
            content(success)
        case let .failure(error):
            Text(verbatim: error.localizedDescription)
                .body(textColor: .appRed)
        }
    }
}
