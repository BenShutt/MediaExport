//
//  LoadStateView.swift
//  MediaExport
//
//  Created by Ben Shutt on 21/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct LoadStateView<Success, Content: View>: View {

    var state: LoadState<Success>
    @ViewBuilder var content: (Success) -> Content

    var body: some View {
        switch state {
        case let .success(success):
            content(success)
        case let .failure(error):
            Text(verbatim: error.localizedDescription)
                .body()
        default:
            LoadingView()
        }
    }
}
