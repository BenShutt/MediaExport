//
//  AuthorizationScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import SwiftUI

struct AuthorizationScreen: View {

    @EnvironmentObject var navigation: Navigation
    @State private var isPresentingUnauthorizedAlert = false

    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    var body: some View {
        Screen(
            title: "authorization_title",
            subtitle: "authorization_subtitle"
        ) {
            Image(.accessPhotoLibrary)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth * 2 / 3)
        }
        .modifier(
            StickyButton(
                key: "continue_button",
                onTap: { onContinue() }
            )
        )
        .alert(
            "unauthorized_alert_title",
            isPresented: $isPresentingUnauthorizedAlert,
            actions: {
                Button("dismiss", role: .cancel) {}
            },
            message: {
                Text("unauthorized_alert_message")
            }
        )
    }

    private func onContinue() {
        guard !AuthorizationManager.isAuthorized() else {
            navigation.push(.assets)
            return
        }

        AuthorizationManager.requestAuthorization { isAuthorized in
            guard isAuthorized else {
                isPresentingUnauthorizedAlert = true
                return
            }
            navigation.push(.assets)
        }
    }
}

// MARK: - Preview

#Preview {
    AuthorizationScreen()
        .environmentObject(Navigation())
}
