import SwiftUI

struct OTPVerificationView: View {
    let phoneNumber: String
    let countryDialCode: String
    let onVerificationSuccess: () -> Void
    let onBack: () -> Void

    @State private var otpCode: String = ""
    @State private var timerSeconds: Int = 30
    @State private var timerTriggerId: UUID = UUID()
    @State private var isError: Bool = false
    @State private var errorMessage: String = ""
    @State private var shakeOffset: CGFloat = 0
    @FocusState private var isFocused: Bool

    var formattedPhone: String {
        "\(countryDialCode) \(phoneNumber)"
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header Bar
            HStack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.blinkitCharcoal)
                        .frame(width: 44, height: 44, alignment: .leading)
                }

                Spacer()

                Text("OTP Verification")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(Color.blinkitCharcoal)

                Spacer()

                // Balance layout
                Color.clear
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)

            ScrollView {
                VStack(spacing: 28) {
                    // Subtitle & Phone Number
                    VStack(spacing: 6) {
                        Text("We have sent a verification code to")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color.blinkitSubtitle)

                        Text(formattedPhone)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color.blinkitCharcoal)
                    }
                    .padding(.top, 32)

                    // 4 OTP Boxes
                    ZStack {
                        // Hidden TextField for system keypad
                        TextField("", text: $otpCode)
                            .keyboardType(.numberPad)
                            .textContentType(.oneTimeCode)
                            .focused($isFocused)
                            .accentColor(.clear)
                            .foregroundColor(.clear)
                            .frame(width: 1, height: 1)
                            .opacity(0.01)
                            .onChange(of: otpCode) { _, newValue in
                                handleOtpChange(newValue)
                            }

                        // Visible 4 boxes
                        HStack(spacing: 16) {
                            ForEach(0..<4, id: \.self) { index in
                                otpBox(at: index)
                            }
                        }
                        .offset(x: shakeOffset)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isFocused = true
                    }

                    // Error Message
                    if isError {
                        HStack(spacing: 6) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .font(.system(size: 14))
                            Text(errorMessage)
                                .font(.system(size: 13, weight: .medium))
                        }
                        .foregroundColor(.red)
                        .transition(.opacity)
                    }

                    // Resend Timer or Button
                    if timerSeconds > 0 {
                        Text("Resend OTP in \(timerSeconds)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.blinkitSubtitle.opacity(0.8))
                    } else {
                        Button(action: resendOtp) {
                            Text("Resend OTP")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color.blinkitGreen)
                        }
                    }

                    // Test Hint Banner
                    HStack(spacing: 4) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(Color.blinkitGreen)
                        Text("Default verification code is")
                            .foregroundColor(Color.blinkitSubtitle)
                        Text("1234")
                            .bold()
                            .foregroundColor(Color.blinkitGreen)
                    }
                    .font(.system(size: 13))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blinkitGreen.opacity(0.08))
                    .cornerRadius(8)
                    .padding(.top, 10)
                }
                .padding(.horizontal, 24)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isFocused = true
            }
        }
        .task(id: timerTriggerId) {
            while timerSeconds > 0 {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                if Task.isCancelled { break }
                timerSeconds -= 1
            }
        }
    }

    // MARK: - OTP Single Box
    @ViewBuilder
    private func otpBox(at index: Int) -> some View {
        let char: String = {
            if index < otpCode.count {
                let stringIndex = otpCode.index(otpCode.startIndex, offsetBy: index)
                return String(otpCode[stringIndex])
            }
            return ""
        }()

        let isCurrentBox = isFocused && (index == otpCode.count || (index == 3 && otpCode.count == 4))

        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.white)
                .frame(width: 58, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(
                            isError ? Color.red : (isCurrentBox ? Color.blinkitCharcoal : Color.blinkitBorder),
                            lineWidth: isCurrentBox || isError ? 1.8 : 1.2
                        )
                )

            Text(char)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color.blinkitCharcoal)
        }
    }

    // MARK: - Logic
    private func handleOtpChange(_ newValue: String) {
        let filtered = String(newValue.filter { $0.isNumber }.prefix(4))
        if filtered != otpCode {
            otpCode = filtered
        }

        if isError {
            isError = false
            errorMessage = ""
        }

        if otpCode.count == 4 {
            verifyOtp()
        }
    }

    private func verifyOtp() {
        if otpCode == "1234" {
            // Success
            isFocused = false
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                onVerificationSuccess()
            }
        } else {
            // Failure shake and message
            isError = true
            errorMessage = "Invalid OTP code. Please enter 1234"
            triggerShake()
        }
    }

    private func triggerShake() {
        withAnimation(.default) {
            shakeOffset = -12
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            withAnimation(.default) {
                shakeOffset = 12
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            withAnimation(.default) {
                shakeOffset = -8
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
            withAnimation(.default) {
                shakeOffset = 0
            }
        }
    }

    private func resendOtp() {
        timerSeconds = 30
        timerTriggerId = UUID()
        otpCode = ""
        isError = false
        errorMessage = ""
        isFocused = true
    }
}

#Preview {
    OTPVerificationView(
        phoneNumber: "9876543210",
        countryDialCode: "+91",
        onVerificationSuccess: {},
        onBack: {}
    )
}
