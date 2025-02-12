//
//  SignInView.swift
//  You
//
//  Created by Oliver Gilcher on 1/28/25.
//

import SwiftUI

@MainActor
final class SignInViewModel : ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}

struct SignInView : View {
    @StateObject private var viewModel = SignInViewModel()
    
    @State private var showingPassword = false
    @Binding var showSignInView : Bool
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 20) {
                // Title text
                Text("Sign In")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
                    .padding(.top, 10)
                
                // Email section
                VStack (alignment: .leading, spacing: 2) {
                    Text("Email")
                    TextField("", text: $viewModel.email)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    
                        .frame(width: 250)
                        .background(Color.gray.opacity(0.4))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white, lineWidth: 1)
                        )
                }
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                
                // Password Section
                VStack (alignment: .leading, spacing: 2) {
                    Text("Password")
                    
                    Group {
                        if showingPassword {
                            TextField("", text: $viewModel.password)
                        } else {
                            SecureField("", text: $viewModel.password)
                        }
                        
                    }
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    
                    .frame(width: 250)
                    .background(Color.gray.opacity(0.4))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1)
                    )
                }
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                
                // TODO: Add sign in options
                
                // Show password checkbox
                HStack {
                    Button(
                        action: {
                            showingPassword.toggle()
                        }, label: {
                            Image(systemName: showingPassword ? "checkmark.square" : "square")
                        }
                    )
                    Text("Show Password")
                    Spacer()
                }
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .semibold))
                
                // Sign in button
                Button {
                    Task {
                        do {
                            try await viewModel.signIn()
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Sign In")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 100)
                        .background(Color.blue)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.top, 20)
                }
                
                // Forgot password button
                NavigationLink(
                    destination: SignInView(showSignInView: $showSignInView).navigationBarBackButtonHidden(true),
                    label: {
                        Text("Forgot password?")
                            .font(.system(size: 18, weight: .semibold))
                    }
                )
                
                // Sign up button
                HStack {
                    Text("Don't have an account?")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundStyle(.white)
                    NavigationLink(
                        destination: SignUpEmailView(showSignInView: $showSignInView).navigationBarBackButtonHidden(true),
                        label: {
                            Text("Sign up")
                                .foregroundStyle(.blue)
                                .font(.system(size: 14, weight: .regular, design: .default))
                        }
                    )
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 50)
            .padding(.vertical)
            .frame(
                width: 350,
                height: 450
            )
            .background(.white.quinary)
            .clipShape(.rect(cornerRadius: 25))
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    VStack {
        SignInView(showSignInView: .constant(true))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea()
    .background(.black.gradient)
}
