import SwiftUI

struct LoginView: View {
    let onLoginSuccess: () -> Void
    let onSkip: () -> Void

    @State private var currentStep: LoginStep = .phoneInput
    @State private var selectedCountry: Country = Country.defaultCountry
    @State private var phoneNumber: String = ""
    @State private var showCountryPicker: Bool = false
    @FocusState private var isPhoneFocused: Bool

    enum LoginStep {
        case phoneInput
        case otpVerification
    }

    private var isContinueEnabled: Bool {
        // Any number with at least 4 digits works as requested
        phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).count >= 4
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            switch currentStep {
            case .phoneInput:
                phoneInputScreen
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            case .otpVerification:
                OTPVerificationView(
                    phoneNumber: phoneNumber,
                    countryDialCode: selectedCountry.dialCode,
                    onVerificationSuccess: onLoginSuccess,
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            currentStep = .phoneInput
                        }
                    }
                )
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .trailing).combined(with: .opacity)
                ))
            }
        }
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerSheet { country in
                selectedCountry = country
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }

    // MARK: - Phone Input Screen
    private var phoneInputScreen: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Top Visual Products Collage
                    ProductCollageView()
                        .frame(height: 340)
                        .clipped()

                    // Bottom Content Block
                    VStack(spacing: 16) {
                        // Blinkit App Icon
                        blinkitIcon
                            .padding(.top, -14)

                        // Title & Subtitle
                        VStack(spacing: 6) {
                            Text("India's last minute app")
                                .font(.system(size: 26, weight: .bold, design: .rounded))
                                .foregroundColor(Color.blinkitCharcoal)

                            Text("Log in or sign up")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.blinkitSubtitle)
                        }

                        // Phone Input Form
                        HStack(spacing: 10) {
                            // Country Selector Button
                            Button(action: {
                                isPhoneFocused = false
                                showCountryPicker = true
                            }) {
                                HStack(spacing: 6) {
                                    Text(selectedCountry.flag)
                                        .font(.system(size: 24))

                                    Image(systemName: "arrowtriangle.down.fill")
                                        .font(.system(size: 8))
                                        .foregroundColor(Color.blinkitCharcoal.opacity(0.7))
                                }
                                .frame(width: 78, height: 52)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.blinkitBorder, lineWidth: 1.2)
                                )
                            }
                            .buttonStyle(.plain)

                            // Mobile Number Field
                            HStack(spacing: 6) {
                                Text(selectedCountry.dialCode)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.blinkitCharcoal)

                                TextField("Enter mobile number", text: $phoneNumber)
                                    .keyboardType(.numberPad)
                                    .focused($isPhoneFocused)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color.blinkitCharcoal)
                                    .onChange(of: phoneNumber) { _, newValue in
                                        let filtered = newValue.filter { $0.isNumber }
                                        if filtered.count > 15 {
                                            phoneNumber = String(filtered.prefix(15))
                                        } else if filtered != newValue {
                                            phoneNumber = filtered
                                        }
                                    }
                            }
                            .padding(.horizontal, 14)
                            .frame(height: 52)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(isPhoneFocused ? Color.blinkitCharcoal.opacity(0.8) : Color.blinkitBorder, lineWidth: 1.2)
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 8)

                        // Continue Button
                        Button(action: {
                            if isContinueEnabled {
                                isPhoneFocused = false
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    currentStep = .otpVerification
                                }
                            }
                        }) {
                            Text("Continue")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(isContinueEnabled ? Color.blinkitGreen : Color.blinkitDisabled)
                                .cornerRadius(12)
                        }
                        .disabled(!isContinueEnabled)
                        .padding(.horizontal, 24)
                        .padding(.top, 4)

                        // Terms and Privacy Footer
                        footerLegalView
                            .padding(.top, 24)
                            .padding(.bottom, 24)
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .ignoresSafeArea(edges: .top)

            // Skip Login Button in Top Right
            Button(action: onSkip) {
                Text("Skip login")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(Color.black.opacity(0.35))
                    .clipShape(Capsule())
            }
            .padding(.trailing, 20)
            .padding(.top, 10)
        }
        .onTapGesture {
            isPhoneFocused = false
        }
    }

    // MARK: - App Icon
    private var blinkitIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.blinkitYellow)
                .frame(width: 64, height: 64)
                .shadow(color: Color.blinkitYellow.opacity(0.4), radius: 6, x: 0, y: 3)

            HStack(spacing: 0) {
                Text("blink")
                    .foregroundColor(Color.blinkitCharcoal)
                Text("it")
                    .foregroundColor(Color.blinkitGreen)
            }
            .font(.system(size: 16, weight: .black, design: .rounded))
            .tracking(-0.3)
        }
    }

    // MARK: - Footer
    private var footerLegalView: some View {
        HStack(spacing: 2) {
            Text("By continuing, you agree to our: ")
                .foregroundColor(Color.blinkitSubtitle)

            Text("Terms of Service")
                .underline()
                .foregroundColor(Color.blinkitSubtitle)

            Text(" & ")
                .foregroundColor(Color.blinkitSubtitle)

            Text("Privacy policy")
                .underline()
                .foregroundColor(Color.blinkitSubtitle)
        }
        .font(.system(size: 11, weight: .medium))
        .padding(.horizontal, 24)
    }
}

#Preview {
    LoginView(onLoginSuccess: {}, onSkip: {})
}
