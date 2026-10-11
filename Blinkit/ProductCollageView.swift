import SwiftUI

struct ProductCollageView: View {
    var body: some View {
        VStack(spacing: 12) {
            // Row 1
            HStack(spacing: 12) {
                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    BananaProductView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    LipstickProductView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    DalPacketView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    JuiceProductView()
                }
            }
            .offset(x: -15)

            // Row 2
            HStack(spacing: 12) {
                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    RicePacketView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    IceCreamTubView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    OilJugView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    LightBulbView()
                }
            }
            .offset(x: 15)

            // Row 3
            HStack(spacing: 12) {
                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    SandwichMakerView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    TeddyBearView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    WoodenSpoonsView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    KetchupBottleView()
                }
            }
            .offset(x: -20)

            // Row 4
            HStack(spacing: 12) {
                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    TeaPouchView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    CokeCanView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    DiaperPackView()
                }

                CollageCard(bgColor: Color(red: 238/255, green: 248/255, blue: 247/255)) {
                    KettleView()
                }
            }
            .offset(x: 10)
        }
        .frame(maxWidth: .infinity)
        .overlay(
            // Bottom fade into white login container
            LinearGradient(
                stops: [
                    .init(color: .clear, location: 0.0),
                    .init(color: .white.opacity(0.0), location: 0.52),
                    .init(color: .white.opacity(0.88), location: 0.85),
                    .init(color: .white, location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

// MARK: - Product Card Container
private struct CollageCard<Content: View>: View {
    let bgColor: Color
    @ViewBuilder let content: () -> Content

    var body: some View {
        ZStack {
            content()
        }
        .frame(width: 96, height: 96)
        .background(bgColor)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(0.85), lineWidth: 1)
        )
    }
}

// MARK: - Individual Product Illustrations
private struct BananaProductView: View {
    var body: some View {
        Text("🍌")
            .font(.system(size: 52))
            .rotationEffect(.degrees(-10))
    }
}

private struct LipstickProductView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Red lipstick tip
            UnevenRoundedRectangle(
                topLeadingRadius: 10,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 2
            )
            .fill(Color(red: 220/255, green: 20/255, blue: 40/255))
            .frame(width: 14, height: 22)

            // Gold band
            Rectangle()
                .fill(Color(red: 218/255, green: 165/255, blue: 32/255))
                .frame(width: 18, height: 4)

            // Black casing
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(red: 25/255, green: 25/255, blue: 25/255))
                .frame(width: 18, height: 28)
                .overlay(
                    Text("REVLON")
                        .font(.system(size: 3.5, weight: .bold))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 4),
                    alignment: .top
                )
        }
        .shadow(color: Color.black.opacity(0.12), radius: 3, x: 0, y: 2)
    }
}

private struct DalPacketView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(LinearGradient(colors: [Color.green.opacity(0.85), Color.yellow.opacity(0.9)], startPoint: .top, endPoint: .bottom))
                .frame(width: 50, height: 64)

            VStack(spacing: 2) {
                Text("TATA")
                    .font(.system(size: 6, weight: .black))
                    .foregroundColor(.white)
                Text("Sampann")
                    .font(.system(size: 5, weight: .bold))
                    .foregroundColor(.white)
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 22, height: 22)
                    .overlay(
                        Text("🌾")
                            .font(.system(size: 13))
                    )
                Text("Toor Dal")
                    .font(.system(size: 5, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
    }
}

private struct JuiceProductView: View {
    var body: some View {
        Text("🧃")
            .font(.system(size: 48))
    }
}

private struct RicePacketView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(red: 235/255, green: 140/255, blue: 50/255))
                .frame(width: 52, height: 66)

            VStack(spacing: 2) {
                Text("DAAWAT")
                    .font(.system(size: 6.5, weight: .heavy))
                    .foregroundColor(.white)

                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.white)
                    .frame(width: 44, height: 12)
                    .overlay(
                        Text("PULAV RICE")
                            .font(.system(size: 5, weight: .black))
                            .foregroundColor(.blue)
                    )

                Circle()
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 22, height: 22)
                    .overlay(
                        Text("🍚")
                            .font(.system(size: 13))
                    )
            }
        }
        .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
    }
}

private struct IceCreamTubView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Scoop on top
            Circle()
                .fill(Color(red: 255/255, green: 253/255, blue: 245/255))
                .frame(width: 32, height: 32)
                .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
                .offset(y: 8)
                .zIndex(1)

            // Cyan Tub
            ZStack {
                UnevenRoundedRectangle(
                    topLeadingRadius: 4,
                    bottomLeadingRadius: 10,
                    bottomTrailingRadius: 10,
                    topTrailingRadius: 4
                )
                .fill(Color(red: 0/255, green: 168/255, blue: 224/255))
                .frame(width: 46, height: 42)

                VStack(spacing: 1) {
                    Text("🍦")
                        .font(.system(size: 10))
                    Text("VANILLA")
                        .font(.system(size: 5.5, weight: .black))
                        .foregroundColor(.white)
                    Text("Kwality Wall's")
                        .font(.system(size: 4, weight: .bold))
                        .foregroundColor(.white.opacity(0.85))
                }
            }
        }
    }
}

private struct OilJugView: View {
    var body: some View {
        ZStack {
            // Yellow jug
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(red: 255/255, green: 200/255, blue: 0/255))
                .frame(width: 46, height: 60)
                .overlay(
                    // Handle cut-out
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(red: 238/255, green: 248/255, blue: 247/255))
                        .frame(width: 10, height: 26)
                        .padding(.trailing, 22)
                )

            VStack(spacing: 1) {
                Text("Fortune")
                    .font(.system(size: 6.5, weight: .black))
                    .foregroundColor(.red)
                Text("🌻")
                    .font(.system(size: 12))
                Text("SUNLITE")
                    .font(.system(size: 4.5, weight: .bold))
                    .foregroundColor(Color(red: 40/255, green: 40/255, blue: 40/255))
            }
            .padding(.leading, 10)
        }
    }
}

private struct LightBulbView: View {
    var body: some View {
        Text("💡")
            .font(.system(size: 48))
    }
}

private struct SandwichMakerView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(width: 56, height: 56)
                .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)

            VStack(spacing: 4) {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .frame(width: 32, height: 22)
                    .overlay(
                        HStack(spacing: 4) {
                            Circle().fill(Color.red).frame(width: 4, height: 4)
                            Circle().fill(Color.green).frame(width: 4, height: 4)
                        }
                    )

                Text("TOASTER")
                    .font(.system(size: 5, weight: .bold))
                    .foregroundColor(.gray)
            }
        }
    }
}

private struct TeddyBearView: View {
    var body: some View {
        ZStack {
            Text("🧸")
                .font(.system(size: 48))

            // Little red heart badge
            Text("❤️")
                .font(.system(size: 14))
                .offset(x: 2, y: 6)
        }
    }
}

private struct WoodenSpoonsView: View {
    var body: some View {
        HStack(spacing: -6) {
            Text("🥄")
                .font(.system(size: 34))
                .rotationEffect(.degrees(-15))
            Text("🥢")
                .font(.system(size: 34))
                .rotationEffect(.degrees(10))
        }
    }
}

private struct KetchupBottleView: View {
    var body: some View {
        VStack(spacing: 0) {
            // White cap
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.white)
                .frame(width: 14, height: 6)

            // Red bottle
            UnevenRoundedRectangle(
                topLeadingRadius: 6,
                bottomLeadingRadius: 10,
                bottomTrailingRadius: 10,
                topTrailingRadius: 6
            )
            .fill(Color(red: 215/255, green: 30/255, blue: 30/255))
            .frame(width: 28, height: 48)
            .overlay(
                VStack(spacing: 1) {
                    Text("HEINZ")
                        .font(.system(size: 5, weight: .black))
                        .foregroundColor(.white)
                    Text("🍅")
                        .font(.system(size: 8))
                    Text("TOMATO")
                        .font(.system(size: 3.5, weight: .bold))
                        .foregroundColor(.white)
                }
            )
        }
    }
}

private struct TeaPouchView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(red: 50/255, green: 135/255, blue: 70/255))
                .frame(width: 46, height: 58)

            VStack(spacing: 2) {
                Text("TATA TEA")
                    .font(.system(size: 5.5, weight: .black))
                    .foregroundColor(.white)
                Text("🌿")
                    .font(.system(size: 12))
                Text("PREMIUM")
                    .font(.system(size: 4, weight: .bold))
                    .foregroundColor(.yellow)
            }
        }
    }
}

private struct CokeCanView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(red: 230/255, green: 20/255, blue: 25/255))
                .frame(width: 32, height: 58)

            VStack(spacing: 2) {
                Text("Coca-Cola")
                    .font(.system(size: 6, weight: .heavy, design: .serif))
                    .italic()
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(-90))
            }
        }
    }
}

private struct DiaperPackView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(red: 0/255, green: 180/255, blue: 175/255))
                .frame(width: 46, height: 56)

            VStack(spacing: 2) {
                Text("Pampers")
                    .font(.system(size: 6, weight: .bold))
                    .foregroundColor(.white)
                Text("👶")
                    .font(.system(size: 14))
                Text("all round")
                    .font(.system(size: 4, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
            }
        }
    }
}

private struct KettleView: View {
    var body: some View {
        Text("🫖")
            .font(.system(size: 48))
    }
}

#Preview {
    ProductCollageView()
}
