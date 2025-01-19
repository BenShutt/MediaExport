//
//  RootNavigationStack.swift
//  MediaExport
//
//  Created by Ben Shutt on 19/01/2025.
//

import SwiftUI

/// `NavigationPath` stores the view data and ought to be stored in a `@State`.
/// It is also preferable to keep it as a value type rather than wrapped in an `ObservableObject`.
/// In order to modify the path, we use environments for
/// * `PushAction`
/// * `PopAction`
/// * `PopToRootAction`
///
/// # Reference
/// https://gist.github.com/moyerr/ebac14388bf38cb9962dcf33c06032b8
struct RootNavigationStack<Content: View>: View {

    /// Storage of the navigation view stack
    @State private var path = NavigationPath()

    /// The root screen in the stack
    @ViewBuilder var content: () -> Content

    var body: some View {
        NavigationStack(path: $path) {
            content()
                .navigateRoutes()
        }
        .environment(\.push, .init { path.append($0) })
        .environment(\.pop, .init { path.removeLast() })
        .environment(\.popToRoot, .init { path = .init() })
    }
}

// MARK: - Environment Structures

struct PushAction: Sendable {
    var action: @MainActor (NavigationRoute) -> Void

    @MainActor
    func callAsFunction(_ value: NavigationRoute) {
        action(value)
    }
}

struct PopAction: Sendable {
    var action: @MainActor () -> Void

    @MainActor
    func callAsFunction() {
        action()
    }
}

struct PopToRootAction: Sendable {
    var action: @MainActor () -> Void

    @MainActor
    func callAsFunction() {
        action()
    }
}

// MARK: - EnvironmentKeys

private struct PushKey: EnvironmentKey {
    static let defaultValue = PushAction { _ in }
}

private struct PopKey: EnvironmentKey {
    static let defaultValue = PopAction {}
}

private struct PopToRootKey: EnvironmentKey {
    static let defaultValue = PopToRootAction {}
}

// MARK: - EnvironmentValues

extension EnvironmentValues {
    var push: PushAction {
        get { self[PushKey.self] }
        set { self[PushKey.self] = newValue }
    }

    var pop: PopAction {
        get { self[PopKey.self] }
        set { self[PopKey.self] = newValue }
    }

    var popToRoot: PopToRootAction {
        get { self[PopToRootKey.self] }
        set { self[PopToRootKey.self] = newValue }
    }
}
