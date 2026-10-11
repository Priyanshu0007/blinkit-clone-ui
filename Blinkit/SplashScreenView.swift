import SwiftUI

struct SplashScreenView: View {
    // Brand Colors matching Blinkit design
    private let brandYellow = Color(red: 248/255, green: 203/255, blue: 62/255)
    private let brandGreen = Color(red: 12/255, green: 131/255, blue: 31/255)
    private let brandCharcoal = Color(red: 26/255, green: 26/255, blue: 26/255)

    @State private var opacity: Double = 0.0
    @State private var scale: CGFloat = 0.95

    var body: some View {
        ZStack {
            brandYellow
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Brand Header Block
                VStack(spacing: 8) {
                    // "blinkit" Logo
                    HStack(spacing: 0) {
                        Text("blink")
                            .foregroundColor(brandCharcoal)
                        Text("it")
                            .foregroundColor(brandGreen)
                    }
                    .font(.system(size: 62, weight: .black, design: .rounded))
                    .tracking(-1.0)

                    // Subtitle
                    Text("India’s Last Minute App")
                        .font(.system(size: 19, weight: .bold, design: .rounded))
                        .foregroundColor(brandCharcoal)
                }

                // Subtle Divider with Soft Shadow
                ZStack {
                    LinearGradient(
                        colors: [
                            Color.black.opacity(0.0),
                            Color.black.opacity(0.06),
                            Color.black.opacity(0.0)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: 220, height: 4)
                    .blur(radius: 2)
                    .offset(y: 2)

                    LinearGradient(
                        colors: [
                            Color.black.opacity(0.0),
                            Color.black.opacity(0.14),
                            Color.black.opacity(0.0)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: 190, height: 1)
                }
                .padding(.top, 28)
                .padding(.bottom, 24)

                // Eternal Company Tagline
                Text("AN ETERNAL COMPANY")
                    .font(.system(size: 13, weight: .heavy, design: .default))
                    .tracking(2.6)
                    .foregroundColor(brandCharcoal)

                Spacer()
                // Optical vertical centering matching screenshot
                Spacer().frame(height: 50)
            }
            .opacity(opacity)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeOut(duration: 0.6)) {
                    opacity = 1.0
                    scale = 1.0
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
