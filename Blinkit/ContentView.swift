import SwiftUI

struct ContentView: View {
    @State private var showSplash: Bool = true

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
            } else {
                HomeView()
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    ContentView()
}
