//
//  AuthorizationScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.

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
                .accessibilityHidden(true)
        }
        .modifier(
            StickyButton(
                key: "continue_button",
                onTap: {
                    Task { await onContinue() }
                }
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

    private func onContinue() async {
        guard !AuthorizationManager.isAuthorized else {
            navigation.push(.assets)
            return
        }

        let isAuthorized = await AuthorizationManager.requestAuthorization()
        if isAuthorized {
            navigation.push(.assets)
        } else {
            isPresentingUnauthorizedAlert = true
        }
    }
}

// MARK: - Preview

#Preview {
    AuthorizationScreen()
        .environmentObject(Navigation())
}
