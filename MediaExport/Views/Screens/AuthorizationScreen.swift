//
//  AuthorizationScreen.swift
//  MediaExport
//
//  Created by Ben Shutt on 20/09/2023.
//

import SwiftUI

struct AuthorizationScreen: View {
    @Environment(\.push) private var push
    @State private var isPresentingUnauthorizedAlert = false

    var body: some View {
        GeometryReader { metrics in
            Screen(
                title: "authorization_title",
                subtitle: "authorization_subtitle"
            ) {
                Image(.accessPhotoLibrary)
                    .resizable()
                    .scaledToFit()
                    .frame(width: metrics.size.width * 2 / 3)
                    .accessibilityHidden(true)
            }
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
        let authorization = AuthorizationManager()
        guard !authorization.isAuthorized else {
            push(.assets)
            return
        }

        let isAuthorized = await authorization.requestAuthorization()
        if isAuthorized {
            push(.assets)
        } else {
            isPresentingUnauthorizedAlert = true
        }
    }
}

// MARK: - Preview

#Preview {
    AuthorizationScreen()
}
