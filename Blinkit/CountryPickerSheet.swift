import SwiftUI

struct CountryPickerSheet: View {
    let onSelect: (Country) -> Void
    @Environment(\.dismiss) private var dismiss

    @State private var searchText: String = ""

    private var filteredCountries: [Country] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return Country.allCountries
        } else {
            let query = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return Country.allCountries.filter { country in
                country.name.lowercased().contains(query) ||
                country.dialCode.contains(query) ||
                country.code.lowercased().contains(query)
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Floating Close Button above sheet header
            Button(action: { dismiss() }) {
                ZStack {
                    Circle()
                        .fill(Color.blinkitCharcoal.opacity(0.85))
                        .frame(width: 38, height: 38)

                    Image(systemName: "xmark")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 8)

            // Sheet Card
            VStack(alignment: .leading, spacing: 16) {
                // Title
                Text("Select your country")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.blinkitCharcoal)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                // Search Bar
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.blinkitSubtitle)

                    TextField("Search by your country name", text: $searchText)
                        .font(.system(size: 15))
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)

                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal, 14)
                .frame(height: 48)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blinkitBorder, lineWidth: 1)
                )
                .padding(.horizontal, 20)

                // Countries List
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredCountries) { country in
                            Button(action: {
                                onSelect(country)
                                dismiss()
                            }) {
                                HStack(spacing: 16) {
                                    Text(country.flag)
                                        .font(.system(size: 28))

                                    Text(country.name)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color.blinkitCharcoal)

                                    Spacer()

                                    Text(country.dialCode)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color.blinkitSubtitle)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom, 32)
                }
            }
            .background(Color.white)
            .clipShape(RoundedCornerShape(radius: 24, corners: [.topLeft, .topRight]))
        }
        .background(Color.clear)
    }
}

// Custom shape for top rounded corners
struct RoundedCornerShape: Shape {
    var radius: CGFloat = 24
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    CountryPickerSheet(onSelect: { _ in })
}
