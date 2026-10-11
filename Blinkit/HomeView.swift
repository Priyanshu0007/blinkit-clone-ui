import SwiftUI

struct HomeView: View {
    var onLogout: (() -> Void)? = nil

    @State private var searchText: String = ""
    @State private var showLogoutConfirmation: Bool = false

    private let brandYellow = Color.blinkitYellow
    private let brandGreen = Color.blinkitGreen
    private let brandCharcoal = Color.blinkitCharcoal

    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerView

            // Content
            ScrollView {
                VStack(spacing: 20) {
                    // Search Bar
                    searchBarView

                    // Clean Placeholder Banner
                    welcomeBannerView

                    Spacer()
                }
                .padding(.top, 16)
            }
        }
        .background(Color.blinkitBackground)
        .confirmationDialog("Account", isPresented: $showLogoutConfirmation) {
            Button("Log Out", role: .destructive) {
                onLogout?()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to log out?")
        }
    }

    // MARK: - Header
    private var headerView: some View {
        VStack(spacing: 12) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text("Blinkit in")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(brandCharcoal)
                        Text("10 minutes")
                            .font(.system(size: 16, weight: .black))
                            .foregroundColor(brandGreen)
                    }

                    HStack(spacing: 4) {
                        Text("HOME - 402, Green Avenue, Sector 45")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(brandCharcoal.opacity(0.7))
                            .lineLimit(1)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(brandCharcoal.opacity(0.7))
                    }
                }

                Spacer()

                Button(action: {
                    showLogoutConfirmation = true
                }) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(brandCharcoal)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .padding(.bottom, 12)
        .background(brandYellow)
    }

    // MARK: - Search Bar
    private var searchBarView: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)

            TextField("Search \"milk\", \"bread\", \"chips\"...", text: $searchText)
                .font(.system(size: 14))

            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }

            Image(systemName: "mic.fill")
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 16)
    }

    // MARK: - Welcome Banner
    private var welcomeBannerView: some View {
        VStack(spacing: 16) {
            Image(systemName: "cart.fill")
                .font(.system(size: 44))
                .foregroundColor(brandGreen)

            VStack(spacing: 6) {
                Text("Welcome to Blinkit")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(brandCharcoal)

                Text("Everything delivered in 10 minutes")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 48)
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
}
