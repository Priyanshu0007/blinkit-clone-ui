import SwiftUI

struct ContentView: View {
    @State private var showSplash: Bool = true
    @State private var isAuthenticated: Bool = false

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showSplash = false
                        }
                    }
                    .task {
                        try? await Task.sleep(nanoseconds: 2_200_000_000)
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showSplash = false
                        }
                    }
            } else if isAuthenticated {
                HomeView(onLogout: {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        isAuthenticated = false
                    }
                })
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .scale(scale: 0.98)),
                    removal: .opacity
                ))
            } else {
                LoginView(
                    onLoginSuccess: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            isAuthenticated = true
                        }
                    },
                    onSkip: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            isAuthenticated = true
                        }
                    }
                )
                .transition(.asymmetric(
                    insertion: .opacity,
                    removal: .opacity.combined(with: .scale(scale: 1.02))
                ))
            }
        }
    }
}

#Preview {
    ContentView()
}
