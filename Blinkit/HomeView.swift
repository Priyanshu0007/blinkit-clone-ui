import SwiftUI

struct HomeView: View {
    var onLogout: (() -> Void)? = nil

    @State private var searchText: String = ""
    @State private var selectedTab: Int = 0
    @State private var selectedCategoryIndex: Int = 0
    @State private var showLogoutConfirmation: Bool = false

    private let festiveRedTop = Color(red: 218/255, green: 28/255, blue: 58/255)
    private let festiveRedMid = Color(red: 165/255, green: 14/255, blue: 45/255)
    private let festiveMaroonDark = Color(red: 92/255, green: 8/255, blue: 30/255)

    var body: some View {
        ZStack(alignment: .bottom) {
            // Main Scrollable Screen
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // Festive Top Section (Header, Search, Categories, Powered By, Raksha Bandhan Grid)
                    festiveTopSection

                    // Scalloped Toran Border Divider
                    scallopedDividerView

                    // Bestsellers Section
                    bestsellersSection

                    // Bottom padding for docked tab bar
                    Spacer()
                        .frame(height: 80)
                }
            }
            .ignoresSafeArea(edges: .top)
            .background(Color(red: 247/255, green: 248/255, blue: 250/255))

            // Docked Bottom Tab Bar
            dockedTabBarView
        }
        .preferredColorScheme(.light)
        .confirmationDialog("Account", isPresented: $showLogoutConfirmation) {
            Button("Log Out", role: .destructive) {
                onLogout?()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to log out?")
        }
    }

    // MARK: - Festive Top Section
    private var festiveTopSection: some View {
        ZStack(alignment: .top) {
            // Festive Gradient Background
            LinearGradient(
                colors: [festiveRedTop, festiveRedMid, festiveMaroonDark],
                startPoint: .top,
                endPoint: .bottom
            )

            // Geometric Jali Floral Lattice Background Pattern
            FestiveJaliOverlay()
                .opacity(0.12)
                .frame(maxHeight: 560)
                .clipped()

            VStack(spacing: 12) {
                // Status bar spacer
                Spacer().frame(height: 48)

                // Header Row (Delivery info & Action buttons)
                headerRowView
                    .padding(.horizontal, 16)

                // Search Bar
                searchBarView
                    .padding(.horizontal, 16)
                    .padding(.top, 2)

                // Category Tabs Bar
                categoryTabBarView
                    .padding(.horizontal, 14)
                    .padding(.top, 4)

                // "POWERED BY" banner with floral toran & brand pill
                poweredByBannerView
                    .padding(.top, 6)

                // Festive Cards Grid (Rakhi Tall Card + 2x2 Grid)
                festiveCardsGridView
                    .padding(.horizontal, 14)
                    .padding(.top, 6)
                    .padding(.bottom, 16)
            }
        }
    }

    // MARK: - Header Row
    private var headerRowView: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 1) {
                Text("Blinkit in")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)

                Text("11 minutes")
                    .font(.system(size: 32, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)

                HStack(spacing: 5) {
                    Text("Delhi High Court, India Gate")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)

                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.system(size: 9))
                        .foregroundColor(.white)
                }
                .padding(.top, 1)
            }

            Spacer()

            HStack(spacing: 10) {
                // Green Rewards/Wallet Button
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 45/255, green: 88/255, blue: 38/255))
                            .frame(width: 38, height: 38)

                        // Cash bill + Coin icon
                        ZStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color(red: 60/255, green: 170/255, blue: 75/255))
                                .frame(width: 17, height: 11)
                                .rotationEffect(.degrees(-15))

                            Circle()
                                .fill(Color(red: 245/255, green: 198/255, blue: 45/255))
                                .frame(width: 13, height: 13)
                                .offset(x: 2, y: 1)
                                .overlay(
                                    Text("₹")
                                        .font(.system(size: 8, weight: .black))
                                        .foregroundColor(Color(red: 120/255, green: 70/255, blue: 0/255))
                                        .offset(x: 2, y: 1)
                                )
                        }
                    }
                }

                // Profile Avatar Button
                Button(action: {
                    showLogoutConfirmation = true
                }) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 62/255, green: 12/255, blue: 25/255))
                            .frame(width: 38, height: 38)

                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 38))
                            .foregroundColor(Color(red: 235/255, green: 220/255, blue: 225/255))
                    }
                }
            }
        }
    }

    // MARK: - Search Bar
    private var searchBarView: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 35/255))

            TextField("Search \"stationery\"", text: $searchText)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(red: 35/255, green: 35/255, blue: 40/255))

            Spacer()

            // Vertical divider
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 1, height: 22)

            // Mic Icon
            Image(systemName: "mic.fill")
                .font(.system(size: 18))
                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 35/255))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 2)
    }

    // MARK: - Category Tabs Bar
    private var categoryTabBarView: some View {
        HStack(alignment: .top, spacing: 0) {
            categoryTabItem(title: "All", isSelected: selectedCategoryIndex == 0, index: 0) {
                Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                    .font(.system(size: 21))
                    .foregroundColor(.white)
            }

            Spacer()

            categoryTabItem(title: "Electronics", isSelected: selectedCategoryIndex == 1, index: 1) {
                Image(systemName: "headphones")
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundColor(.white)
            }

            Spacer()

            categoryTabItem(title: "Beauty", isSelected: selectedCategoryIndex == 2, index: 2) {
                HStack(spacing: 2) {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white, lineWidth: 1.8)
                        .frame(width: 8, height: 17)
                        .overlay(
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 4, height: 6),
                            alignment: .top
                        )
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white, lineWidth: 1.8)
                        .frame(width: 9, height: 13)
                }
            }

            Spacer()

            categoryTabItem(title: "Monsoon", isSelected: selectedCategoryIndex == 3, index: 3) {
                ZStack(alignment: .top) {
                    Image(systemName: "umbrella")
                        .font(.system(size: 21, weight: .medium))
                        .foregroundColor(.white)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 2.5, height: 2.5)
                        .offset(x: -7, y: 15)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 2.5, height: 2.5)
                        .offset(x: 7, y: 15)
                }
            }

            Spacer()

            categoryTabItem(title: "Kids", isSelected: selectedCategoryIndex == 4, index: 4) {
                HStack(spacing: 2) {
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.white, lineWidth: 1.8)
                        .frame(width: 10, height: 18)
                        .overlay(
                            VStack(spacing: 2) {
                                Rectangle().fill(Color.white).frame(width: 5, height: 1)
                                Rectangle().fill(Color.white).frame(width: 5, height: 1)
                            }
                        )
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 2, height: 16)
                }
            }
        }
    }

    private func categoryTabItem<IconContent: View>(
        title: String,
        isSelected: Bool,
        index: Int,
        @ViewBuilder icon: () -> IconContent
    ) -> some View {
        Button(action: {
            selectedCategoryIndex = index
        }) {
            VStack(spacing: 5) {
                icon()
                    .frame(height: 26)

                Text(title)
                    .font(.system(size: 12, weight: isSelected ? .bold : .medium))
                    .foregroundColor(.white)

                if isSelected {
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 32, height: 3.5)
                        .padding(.top, 1)
                } else {
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 32, height: 3.5)
                        .padding(.top, 1)
                }
            }
            .frame(width: 66)
        }
    }

    // MARK: - "POWERED BY" Banner
    private var poweredByBannerView: some View {
        ZStack {
            HStack {
                FestiveToranFlourish(isMirrored: false)
                    .frame(width: 80, height: 38)
                    .offset(x: -8)
                Spacer()
                FestiveToranFlourish(isMirrored: true)
                    .frame(width: 80, height: 38)
                    .offset(x: 8)
            }

            VStack(spacing: 4) {
                Text("P O W E R E D   B Y")
                    .font(.system(size: 10, weight: .heavy))
                    .foregroundColor(Color(red: 236/255, green: 202/255, blue: 138/255))
                    .tracking(2.5)

                HStack(spacing: 16) {
                    Text("lifelong")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text("boAt")
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(.white)

                    Text("GIVA")
                        .font(.system(size: 12, weight: .bold, design: .serif))
                        .foregroundColor(.white)

                    Text("Cadbury")
                        .font(.system(size: 13, weight: .medium, design: .serif))
                        .italic()
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Color(red: 72/255, green: 6/255, blue: 24/255))
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color(red: 230/255, green: 180/255, blue: 100/255).opacity(0.35), lineWidth: 0.8)
                )
            }
        }
    }

    // MARK: - Festive Cards Grid (Rakhi Card + 2x2 Grid)
    private var festiveCardsGridView: some View {
        HStack(spacing: 10) {
            // Left Tall Card: "Rakhi, Lumba & More"
            rakhiTallCardView
                .frame(maxWidth: .infinity)

            // Right 2x2 Cards Grid
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    festiveSmallCard(title: "Gifts for\nBrothers") {
                        BrothersGiftsIllustration()
                    }

                    festiveSmallCard(title: "Chocolates &\nGift Packs") {
                        ChocolatesPacksIllustration()
                    }
                }

                HStack(spacing: 10) {
                    festiveSmallCard(title: "Gifts for\nSisters") {
                        SistersGiftsIllustration()
                    }

                    festiveSmallCard(title: "Sweets &\nDry Fruits") {
                        SweetsDryFruitsIllustration()
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 270)
    }

    // Tall Rakhi Card
    private var rakhiTallCardView: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(red: 254/255, green: 240/255, blue: 218/255))

                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        LinearGradient(
                            colors: [
                                Color(red: 234/255, green: 72/255, blue: 98/255),
                                Color(red: 204/255, green: 38/255, blue: 72/255)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )

                        Text("Rakhi, Lumba\n& More")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, 14)
                    }
                    .frame(height: geo.size.height * 0.45)
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 18,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 18,
                            style: .continuous
                        )
                    )

                    Spacer()
                }

                // Middle Lotus Arched Golden Divider
                GoldenLotusArch()
                    .frame(width: geo.size.width, height: 42)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.45)

                // Bottom: Intricate Rakhi Bracelet Illustration
                RakhiBraceletView()
                    .frame(width: geo.size.width, height: 90)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.72)
            }
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
        }
    }

    // Small Festive 2x2 Card helper
    private func festiveSmallCard<Illustration: View>(
        title: String,
        @ViewBuilder illustration: () -> Illustration
    ) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 12.5, weight: .bold))
                .foregroundColor(Color(red: 35/255, green: 24/255, blue: 22/255))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 8)
                .padding(.horizontal, 4)

            Spacer(minLength: 0)

            illustration()
                .frame(height: 72)
                .padding(.bottom, 6)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 254/255, green: 243/255, blue: 231/255))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
    }

    // MARK: - Scalloped Toran Border Divider
    private var scallopedDividerView: some View {
        ZStack(alignment: .top) {
            Color(red: 247/255, green: 248/255, blue: 250/255)
                .frame(height: 22)

            HStack(spacing: 0) {
                ForEach(0..<18, id: \.self) { _ in
                    VStack(spacing: 3) {
                        ScallopShape()
                            .fill(festiveMaroonDark)
                            .frame(width: 22, height: 8)

                        Circle()
                            .fill(festiveMaroonDark)
                            .frame(width: 4, height: 4)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }

    // MARK: - Bestsellers Section
    private var bestsellersSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Bestsellers")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(red: 26/255, green: 26/255, blue: 26/255))
                .padding(.horizontal, 16)
                .padding(.top, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    bestsellerCategoryCard(
                        title: "Vegetables &",
                        moreCount: "+129 more"
                    ) {
                        VegetablesGridIllustration()
                    }

                    bestsellerCategoryCard(
                        title: "Oil, Ghee &",
                        moreCount: "+151 more"
                    ) {
                        OilsGridIllustration()
                    }

                    bestsellerCategoryCard(
                        title: "Dairy, Bread &",
                        moreCount: "+33 more"
                    ) {
                        DairyGridIllustration()
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private func bestsellerCategoryCard<Content: View>(
        title: String,
        moreCount: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .center, spacing: 6) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color(red: 242/255, green: 246/255, blue: 248/255))
                    .frame(width: 112, height: 120)

                content()
                    .frame(width: 104, height: 96)
                    .padding(.bottom, 14)

                Text(moreCount)
                    .font(.system(size: 10.5, weight: .semibold))
                    .foregroundColor(Color(red: 100/255, green: 110/255, blue: 125/255))
                    .padding(.horizontal, 7)
                    .padding(.vertical, 2.5)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule().stroke(Color.gray.opacity(0.2), lineWidth: 0.8)
                    )
                    .offset(y: -4)
            }

            Text(title)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color(red: 30/255, green: 30/255, blue: 35/255))
                .lineLimit(1)
        }
    }

    // MARK: - Docked Bottom Tab Bar
    private var dockedTabBarView: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color.gray.opacity(0.18))

            HStack {
                Button(action: { selectedTab = 0 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 20))
                            .foregroundColor(Color.blinkitYellow)

                        Text("Home")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color(red: 26/255, green: 26/255, blue: 26/255))
                    }
                    .frame(maxWidth: .infinity)
                }

                Button(action: { selectedTab = 1 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "bag")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color(red: 110/255, green: 115/255, blue: 125/255))

                        Text("Order Again")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color(red: 110/255, green: 115/255, blue: 125/255))
                    }
                    .frame(maxWidth: .infinity)
                }

                Button(action: { selectedTab = 2 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "circle.grid.2x2")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color(red: 110/255, green: 115/255, blue: 125/255))

                        Text("Categories")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color(red: 110/255, green: 115/255, blue: 125/255))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 4)
            .background(Color.white)
        }
        .background(Color.white)
    }
}

// MARK: - Scallop Toran Shape
struct ScallopShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: 0),
            control: CGPoint(x: rect.width / 2, y: rect.height)
        )
        path.closeSubpath()
        return path
    }
}

// MARK: - Festive Jali Geometric Overlay
struct FestiveJaliOverlay: View {
    var body: some View {
        VStack(spacing: 28) {
            ForEach(0..<10, id: \.self) { _ in
                HStack(spacing: 28) {
                    ForEach(0..<8, id: \.self) { _ in
                        ZStack {
                            Rectangle()
                                .stroke(Color.white.opacity(0.4), lineWidth: 0.6)
                                .frame(width: 18, height: 18)
                                .rotationEffect(.degrees(45))

                            Circle()
                                .stroke(Color.white.opacity(0.35), lineWidth: 0.6)
                                .frame(width: 14, height: 14)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Festive Toran Side Flourish (Floral Garland)
struct FestiveToranFlourish: View {
    let isMirrored: Bool

    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 10, y: 28))
                path.addCurve(
                    to: CGPoint(x: 70, y: 15),
                    control1: CGPoint(x: 35, y: 35),
                    control2: CGPoint(x: 55, y: 10)
                )
            }
            .stroke(Color(red: 236/255, green: 202/255, blue: 138/255), lineWidth: 1.5)

            HStack(spacing: 3) {
                ZStack {
                    Capsule()
                        .fill(Color(red: 245/255, green: 65/255, blue: 110/255))
                        .frame(width: 8, height: 16)
                    Capsule()
                        .fill(Color(red: 255/255, green: 90/255, blue: 135/255))
                        .frame(width: 8, height: 14)
                        .rotationEffect(.degrees(28))
                    Capsule()
                        .fill(Color(red: 255/255, green: 90/255, blue: 135/255))
                        .frame(width: 8, height: 14)
                        .rotationEffect(.degrees(-28))
                }

                Circle()
                    .fill(Color(red: 236/255, green: 202/255, blue: 138/255))
                    .frame(width: 5, height: 5)
                Circle()
                    .fill(Color(red: 236/255, green: 202/255, blue: 138/255))
                    .frame(width: 4, height: 4)
            }
            .offset(x: -12, y: 0)
        }
        .scaleEffect(x: isMirrored ? -1 : 1, y: 1)
    }
}

// MARK: - Golden Lotus Arch on Tall Rakhi Card
struct GoldenLotusArch: View {
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 22))
                path.addQuadCurve(to: CGPoint(x: 170, y: 22), control: CGPoint(x: 85, y: 4))
            }
            .stroke(
                LinearGradient(
                    colors: [
                        Color(red: 245/255, green: 215/255, blue: 155/255),
                        Color(red: 215/255, green: 170/255, blue: 90/255),
                        Color(red: 245/255, green: 215/255, blue: 155/255)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                lineWidth: 2
            )

            ZStack {
                Capsule()
                    .fill(Color(red: 245/255, green: 215/255, blue: 150/255))
                    .frame(width: 6, height: 16)

                Capsule()
                    .fill(Color(red: 235/255, green: 195/255, blue: 125/255))
                    .frame(width: 6, height: 14)
                    .rotationEffect(.degrees(28))

                Capsule()
                    .fill(Color(red: 235/255, green: 195/255, blue: 125/255))
                    .frame(width: 6, height: 14)
                    .rotationEffect(.degrees(-28))

                Capsule()
                    .fill(Color(red: 225/255, green: 180/255, blue: 105/255))
                    .frame(width: 5, height: 12)
                    .rotationEffect(.degrees(50))

                Capsule()
                    .fill(Color(red: 225/255, green: 180/255, blue: 105/255))
                    .frame(width: 5, height: 12)
                    .rotationEffect(.degrees(-50))
            }
            .offset(y: -4)
        }
    }
}

// MARK: - Rakhi Bracelet View
struct RakhiBraceletView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                LinearGradient(
                    colors: [
                        Color(red: 200/255, green: 30/255, blue: 40/255),
                        Color(red: 245/255, green: 195/255, blue: 60/255),
                        Color(red: 200/255, green: 30/255, blue: 40/255)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 3.5)

                Spacer().frame(width: 70)

                LinearGradient(
                    colors: [
                        Color(red: 200/255, green: 30/255, blue: 40/255),
                        Color(red: 245/255, green: 195/255, blue: 60/255),
                        Color(red: 200/255, green: 30/255, blue: 40/255)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 3.5)
            }

            HStack(spacing: 4) {
                Circle()
                    .fill(Color(red: 245/255, green: 245/255, blue: 245/255))
                    .frame(width: 9, height: 9)
                Circle()
                    .fill(Color(red: 220/255, green: 175/255, blue: 70/255))
                    .frame(width: 8, height: 8)
                Circle()
                    .fill(Color(red: 245/255, green: 245/255, blue: 245/255))
                    .frame(width: 10, height: 10)
            }
            .offset(x: -42)

            HStack(spacing: 4) {
                Circle()
                    .fill(Color(red: 245/255, green: 245/255, blue: 245/255))
                    .frame(width: 10, height: 10)
                Circle()
                    .fill(Color(red: 220/255, green: 175/255, blue: 70/255))
                    .frame(width: 8, height: 8)
                Circle()
                    .fill(Color(red: 245/255, green: 245/255, blue: 245/255))
                    .frame(width: 9, height: 9)
            }
            .offset(x: 42)

            ZStack {
                ForEach(0..<14) { i in
                    Circle()
                        .fill(Color(red: 250/255, green: 248/255, blue: 240/255))
                        .frame(width: 6, height: 6)
                        .offset(x: cos(Double(i) * .pi / 7.0) * 22, y: sin(Double(i) * .pi / 7.0) * 22)
                }

                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [Color(red: 245/255, green: 220/255, blue: 130/255), Color(red: 195/255, green: 150/255, blue: 50/255)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
                    .frame(width: 38, height: 38)

                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color(red: 140/255, green: 215/255, blue: 200/255),
                                Color(red: 65/255, green: 155/255, blue: 140/255),
                                Color(red: 30/255, green: 90/255, blue: 85/255)
                            ],
                            center: .topLeading,
                            startRadius: 2,
                            endRadius: 18
                        )
                    )
                    .frame(width: 32, height: 32)
                    .overlay(
                        Ellipse()
                            .fill(Color.white.opacity(0.45))
                            .frame(width: 14, height: 8)
                            .rotationEffect(.degrees(-35))
                            .offset(x: -5, y: -5)
                    )
            }
            .shadow(color: Color.black.opacity(0.18), radius: 5, x: 0, y: 3)
        }
    }
}

// MARK: - Small Card Product Illustrations
struct BrothersGiftsIllustration: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            ZStack {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Circle()
                            .fill(Color(red: 35/255, green: 40/255, blue: 45/255))
                            .frame(width: 14, height: 14)
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(red: 28/255, green: 32/255, blue: 38/255))
                            .frame(width: 22, height: 12)
                    }
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 20/255, green: 24/255, blue: 30/255))
                        .frame(width: 8, height: 26)
                        .offset(x: 4)
                }
            }

            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 35/255, green: 30/255, blue: 28/255))
                    .frame(width: 11, height: 48)

                Circle()
                    .stroke(Color(red: 220/255, green: 175/255, blue: 85/255), lineWidth: 2)
                    .background(Circle().fill(Color(red: 22/255, green: 24/255, blue: 28/255)))
                    .frame(width: 24, height: 24)

                Rectangle()
                    .fill(Color(red: 220/255, green: 175/255, blue: 85/255))
                    .frame(width: 1.2, height: 7)
                    .offset(y: -3.5)
            }

            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color(red: 225/255, green: 180/255, blue: 90/255))
                    .frame(width: 10, height: 6)

                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 20/255, green: 22/255, blue: 26/255))
                    .frame(width: 16, height: 34)
                    .overlay(
                        VStack(spacing: 1) {
                            Text("BELLAVITA")
                                .font(.system(size: 2, weight: .bold))
                                .foregroundColor(.white.opacity(0.8))
                            Text("CEO")
                                .font(.system(size: 3, weight: .black))
                                .foregroundColor(Color(red: 225/255, green: 180/255, blue: 90/255))
                            Text("MAN")
                                .font(.system(size: 2, weight: .bold))
                                .foregroundColor(.white.opacity(0.8))
                        }
                    )
            }
        }
    }
}

struct ChocolatesPacksIllustration: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(red: 18/255, green: 90/255, blue: 50/255))
                    .frame(width: 32, height: 46)

                VStack(spacing: 2) {
                    Text("Studio")
                        .font(.system(size: 4, weight: .medium, design: .serif))
                        .foregroundColor(Color(red: 240/255, green: 210/255, blue: 120/255))
                    Text("PRALINES")
                        .font(.system(size: 3.5, weight: .black))
                        .foregroundColor(Color(red: 240/255, green: 210/255, blue: 120/255))
                    Circle()
                        .fill(Color(red: 60/255, green: 30/255, blue: 15/255))
                        .frame(width: 12, height: 12)
                }
            }

            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 36, height: 42)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )

                VStack(spacing: 3) {
                    HStack(spacing: 3) {
                        Circle().fill(Color(red: 235/255, green: 185/255, blue: 55/255)).frame(width: 9, height: 9)
                        Circle().fill(Color(red: 235/255, green: 185/255, blue: 55/255)).frame(width: 9, height: 9)
                    }
                    Text("FERRERO\nROCHER")
                        .font(.system(size: 3, weight: .black))
                        .foregroundColor(Color(red: 110/255, green: 75/255, blue: 20/255))
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

struct SistersGiftsIllustration: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 35/255, green: 35/255, blue: 40/255))
                    .frame(width: 15, height: 26)
                    .overlay(
                        VStack(spacing: 1.5) {
                            ForEach(0..<6) { _ in
                                Rectangle().fill(Color(red: 180/255, green: 180/255, blue: 190/255)).frame(width: 11, height: 1)
                            }
                        }
                    )
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 25/255, green: 25/255, blue: 30/255))
                    .frame(width: 8, height: 22)
            }

            HStack(spacing: 3) {
                Image(systemName: "leaf.fill")
                    .font(.system(size: 11))
                    .foregroundColor(Color(red: 200/255, green: 210/255, blue: 225/255))
                Image(systemName: "leaf.fill")
                    .font(.system(size: 11))
                    .foregroundColor(Color(red: 200/255, green: 210/255, blue: 225/255))
            }

            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 25/255, green: 25/255, blue: 28/255))
                    .frame(width: 10, height: 46)

                Circle()
                    .fill(Color.black)
                    .frame(width: 25, height: 25)
                    .overlay(
                        Circle().stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )

                VStack(spacing: 1) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 3.5, height: 3.5)
                    Text("SpO2")
                        .font(.system(size: 3.2, weight: .bold))
                        .foregroundColor(.white)
                    Text("98%")
                        .font(.system(size: 4, weight: .heavy))
                        .foregroundColor(.green)
                }
            }
        }
    }
}

struct SweetsDryFruitsIllustration: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(red: 105/255, green: 25/255, blue: 45/255))
                    .frame(width: 32, height: 46)

                VStack(spacing: 2) {
                    Text("Happilo")
                        .font(.system(size: 4.5, weight: .black, design: .rounded))
                        .foregroundColor(Color(red: 245/255, green: 210/255, blue: 130/255))
                    Text("Celebration")
                        .font(.system(size: 3.5, weight: .bold))
                        .foregroundColor(.white)
                    Text("Dryfruit")
                        .font(.system(size: 3, weight: .medium))
                        .foregroundColor(Color(red: 245/255, green: 210/255, blue: 130/255))
                }
            }

            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(red: 235/255, green: 75/255, blue: 125/255))
                    .frame(width: 36, height: 38)

                VStack(spacing: 2) {
                    Text("Haldiram's")
                        .font(.system(size: 3.5, weight: .bold))
                        .foregroundColor(.yellow)
                    Text("KAJU KATLI")
                        .font(.system(size: 4, weight: .black))
                        .foregroundColor(.white)

                    HStack(spacing: 2) {
                        Rectangle()
                            .fill(Color(red: 230/255, green: 235/255, blue: 240/255))
                            .frame(width: 6, height: 6)
                            .rotationEffect(.degrees(45))
                        Rectangle()
                            .fill(Color(red: 230/255, green: 235/255, blue: 240/255))
                            .frame(width: 6, height: 6)
                            .rotationEffect(.degrees(45))
                    }
                }
            }
        }
    }
}

// MARK: - Bestseller 2x2 Grids
struct VegetablesGridIllustration: View {
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 6) {
                ZStack {
                    Circle()
                        .fill(Color(red: 175/255, green: 80/255, blue: 110/255))
                        .frame(width: 28, height: 26)
                        .overlay(
                            Capsule().fill(Color(red: 140/255, green: 55/255, blue: 85/255)).frame(width: 8, height: 3),
                            alignment: .top
                        )
                    Circle()
                        .fill(Color(red: 195/255, green: 100/255, blue: 130/255))
                        .frame(width: 22, height: 20)
                        .offset(x: 8, y: 2)
                }

                HStack(spacing: 1) {
                    ForEach(0..<3) { i in
                        Capsule()
                            .fill(Color(red: 45/255, green: 165/255, blue: 60/255))
                            .frame(width: 4.5, height: 26)
                            .rotationEffect(.degrees(Double(i * 12 - 12)))
                    }
                }
            }

            HStack(spacing: 6) {
                HStack(spacing: -6) {
                    Circle()
                        .fill(Color(red: 135/255, green: 185/255, blue: 45/255))
                        .frame(width: 17, height: 17)
                    Circle()
                        .fill(Color(red: 120/255, green: 170/255, blue: 35/255))
                        .frame(width: 18, height: 18)
                }

                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(red: 210/255, green: 175/255, blue: 130/255))
                        .frame(width: 24, height: 18)
                        .overlay(
                            Circle().fill(Color(red: 195/255, green: 160/255, blue: 115/255)).frame(width: 10, height: 10),
                            alignment: .topLeading
                        )
                }
            }
        }
    }
}

struct OilsGridIllustration: View {
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white)
                    .frame(width: 20, height: 28)
                    .overlay(
                        VStack(spacing: 1) {
                            Text("Fortune")
                                .font(.system(size: 3, weight: .bold))
                                .foregroundColor(.red)
                            Circle()
                                .fill(Color.yellow)
                                .frame(width: 8, height: 8)
                        }
                    )
                    .border(Color.gray.opacity(0.2), width: 0.5)

                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.yellow)
                        .frame(width: 5, height: 4)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(red: 215/255, green: 145/255, blue: 35/255))
                        .frame(width: 10, height: 24)
                }
            }

            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 250/255, green: 215/255, blue: 60/255))
                    .frame(width: 20, height: 26)
                    .overlay(
                        Text("MAHAKOSH")
                            .font(.system(size: 2.2, weight: .black))
                            .foregroundColor(.blue)
                    )

                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.yellow)
                        .frame(width: 5, height: 4)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(red: 205/255, green: 130/255, blue: 25/255))
                        .frame(width: 10, height: 22)
                }
            }
        }
    }
}

struct DairyGridIllustration: View {
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white)
                    .frame(width: 22, height: 26)
                    .overlay(
                        VStack(spacing: 1) {
                            Text("Amul")
                                .font(.system(size: 3.5, weight: .bold))
                                .foregroundColor(.red)
                            Text("GOLD")
                                .font(.system(size: 2.8, weight: .heavy))
                                .foregroundColor(Color(red: 220/255, green: 160/255, blue: 40/255))
                        }
                    )
                    .border(Color.gray.opacity(0.2), width: 0.5)

                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white)
                    .frame(width: 22, height: 26)
                    .overlay(
                        VStack(spacing: 1) {
                            Text("Amul")
                                .font(.system(size: 3.5, weight: .bold))
                                .foregroundColor(.blue)
                            Text("Taaza")
                                .font(.system(size: 2.8, weight: .heavy))
                                .foregroundColor(.pink)
                        }
                    )
                    .border(Color.gray.opacity(0.2), width: 0.5)
            }

            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white)
                    .frame(width: 22, height: 26)
                    .overlay(
                        VStack(spacing: 1) {
                            Text("Amul")
                                .font(.system(size: 3.5, weight: .bold))
                                .foregroundColor(.blue)
                            Text("Cow Milk")
                                .font(.system(size: 2.5, weight: .medium))
                                .foregroundColor(.blue)
                        }
                    )
                    .border(Color.gray.opacity(0.2), width: 0.5)

                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white)
                    .frame(width: 22, height: 26)
                    .overlay(
                        VStack(spacing: 1) {
                            Circle().fill(Color.blue).frame(width: 6, height: 6)
                            Text("Milk")
                                .font(.system(size: 3, weight: .bold))
                                .foregroundColor(.blue)
                        }
                    )
                    .border(Color.gray.opacity(0.2), width: 0.5)
            }
        }
    }
}

#Preview {
    HomeView()
}
