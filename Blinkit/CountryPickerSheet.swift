import SwiftUI

struct CountryPickerSheet: View {
    @Binding var isPresented: Bool
    let onSelect: (Country) -> Void

    @State private var searchText: String = ""
    @State private var dragOffset: CGFloat = 0
    @State private var animateIn: Bool = false

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
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Dimmed backdrop behind the bottomsheet
                if animateIn {
                    Color.black.opacity(0.45)
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .onTapGesture {
                            dismiss()
                        }
                }

                // Bottomsheet structure (floating button + sheet card)
                if animateIn {
                    VStack(spacing: 14) {
                        // Floating Close Button (floats outside the sheet in the dimmed area)
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
                        .buttonStyle(.plain)
                        .gesture(dismissDragGesture)

                        // Bottom Sheet White Card
                        VStack(alignment: .leading, spacing: 16) {
                            // Title & search area with drag to dismiss
                            VStack(alignment: .leading, spacing: 16) {
                                // Title
                                Text("Select your country")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.blinkitCharcoal)
                                    .padding(.horizontal, 20)
                                    .padding(.top, 20)

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
                            }
                            .contentShape(Rectangle())
                            .gesture(dismissDragGesture)

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
                                .padding(.bottom, 36)
                            }
                            .scrollDismissesKeyboard(.interactively)
                        }
                        .frame(height: min(520, geometry.size.height * 0.62))
                        .background(Color.white)
                        .clipShape(RoundedCornerShape(radius: 24, corners: [.topLeft, .topRight]))
                    }
                    .offset(y: max(0, dragOffset))
                    .transition(.move(edge: .bottom))
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .onAppear {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                animateIn = true
            }
        }
    }

    private var dismissDragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.height > 0 {
                    dragOffset = value.translation.height
                }
            }
            .onEnded { value in
                if value.translation.height > 80 {
                    dismiss()
                } else {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        dragOffset = 0
                    }
                }
            }
    }

    private func dismiss() {
        withAnimation(.easeInOut(duration: 0.22)) {
            animateIn = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
            isPresented = false
        }
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
    CountryPickerSheet(isPresented: .constant(true), onSelect: { _ in })
}
