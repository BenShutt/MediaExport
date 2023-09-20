//
//  AuthorizationScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct AuthorizationScreen: Screen {

    @EnvironmentObject var navigation: Navigation

    let title: LocalizedStringKey = "authorization_title"
    let subtitle: LocalizedStringKey = "authorization_subtitle"

    var stickyButton: StickyButton {
        StickyButton(
            key: "continue_button",
            isEnabled: true
        ) {
            onContinue()
        }
    }

    var content: some View {
        Image("access_photo_library")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width * 0.666)
            .padding(.top, .vPaddingLarge)
    }

    private func onContinue() {
        guard !PhotoLibrary.isAuthorized() else {
            navigation.push(.assets)
            return
        }

        PhotoLibrary.requestAuthorization { isAuthorized in
            guard isAuthorized else { return /* TODO */ }
            navigation.push(.assets)
        }
    }
}

// MARK: - Preview

#Preview {
    AuthorizationScreen()
}
