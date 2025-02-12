//
//  SignUpEmailView.swift
//  You
//
//  Created by Oliver Gilcher on 1/24/25.
//

import SwiftUI

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    @Published var fName = ""
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        // Validate email and password
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
        print(authDataResult.uid)
    }
}

struct SignUpEmailView : View {
    @StateObject private var viewModel = SignUpEmailViewModel()
    
    @State private var showingPassword = false
    @Binding var showSignInView : Bool
    
    @State private var isSubmittedFName: Bool = false
    @State private var isFocusedFName: Bool = false
    @State private var isValidFName: Bool = true
    @State private var providedFName: String = ""
    
    
    var body : some View {
        NavigationStack {
            VStack {
                Text("Welcome to You")
                Text("Create an account to access... ")
                
                HStack {
                    VStack {
                        if isFocusedFName {
                            Text("First name*")
                                .font(.system(size: 10))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("", text: $providedFName)
                                .font(.system(size: 16, weight: .semibold))
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .onSubmit {
                                    if isValidName(valid: providedFName) {
                                        isSubmittedFName = true
                                        isValidFName = true
                                        viewModel.fName = providedFName
                                    } else {
                                        isSubmittedFName = true
                                        isValidFName = false
                                    }
                                }
                        } else {
                            Text("First name*")
                                .onTapGesture {
                                    isFocusedFName = true
                                }
                        }
                    }
                    
                    Spacer()
                    
                    if isSubmittedFName {
                        if isValidFName {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.green)
                                .font(.system(size: 25, weight: .bold))
                        } else {
                            Image(systemName: "xmark")
                                .foregroundStyle(.red)
                                .font(.system(size: 25, weight: .bold))
                        }
                    }
                }
                .padding()
                .frame(width: 350, height: 50)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .stroke(.white.quinary, lineWidth: 2)
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.fromString(from: "voidBlack").gradient)
        }
//        VStack (spacing: 20) {
//            // Header Text
//            Text("Sign Up")
//                .font(.system(size: 35, weight: .bold))
//                .foregroundStyle(.white)
//                .padding(.bottom, 20)
//                .padding(.top, 10)
//            
//            // Email Section
//            VStack (alignment: .leading, spacing: 2) {
//                Text("Email")
//                
//                TextField("", text: $viewModel.email)
//                    .autocorrectionDisabled(true)
//                    .textInputAutocapitalization(.never)
//                
//                    .frame(width: 250)
//                    .background(Color.gray.opacity(0.4))
//                    .clipShape(
//                        RoundedRectangle(cornerRadius: 8)
//                    )
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(.white, lineWidth: 1)
//                    )
//            }
//            .font(.system(size: 18, weight: .semibold))
//            .foregroundStyle(.white)
//            
//            // Password Section
//            VStack (alignment: .leading, spacing: 2) {
//                Text("Password")
//                
//                Group {
//                    if showingPassword {
//                        TextField("", text: $viewModel.password)
//                    } else {
//                        SecureField("", text: $viewModel.password)
//                    }
//                    
//                }
//                .autocorrectionDisabled(true)
//                .textInputAutocapitalization(.never)
//            
//                .frame(width: 250)
//                .background(Color.gray.opacity(0.4))
//                .clipShape(
//                    RoundedRectangle(cornerRadius: 8)
//                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(.white, lineWidth: 1)
//                )
//            }
//            .font(.system(size: 18, weight: .semibold))
//            .foregroundStyle(.white)
//            
//            // Show password checkbox
//            HStack {
//                Button(
//                    action: {
//                        showingPassword.toggle()
//                    }, label: {
//                        Image(systemName: showingPassword ? "checkmark.square" : "square")
//                    }
//                )
//                Text("Show Password")
//                Spacer()
//            }
//            .foregroundStyle(.white)
//            .font(.system(size: 18, weight: .semibold))
//            
//            // Sign up button
//            Button {
//                Task {
//                    do {
//                        try await viewModel.signUp()
//                        showSignInView = false
//                    } catch {
//                        print(error)
//                    }
//                }
//            } label: {
//                Text("Sign Up")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundStyle(.white)
//                    .frame(height: 55)
//                    .frame(maxWidth: 100)
//                    .background(Color.blue)
//                    .clipShape(.rect(cornerRadius: 10))
//                    .padding(.top, 20)
//            }
//            
//            // Sign in button
//            HStack {
//                Text("Already have an account?")
//                    .font(.system(size: 14, weight: .regular, design: .default))
//                    .foregroundStyle(.white)
//                NavigationLink(
//                    destination: SignInView(showSignInView: $showSignInView).navigationBarBackButtonHidden(true),
//                    label: {
//                        Text("Sign in")
//                            .foregroundStyle(Color.blue)
//                            .font(.system(size: 14, weight: .regular, design: .default))
//                    }
//                )
//            }
//            
//            Spacer()
//        }
//        .padding(.horizontal, 50)
//        .padding(.vertical)
//        .frame(
//            width: 350,
//            height: 450
//        )
//        .background(.white.quinary)
//        .clipShape(.rect(cornerRadius: 25))
//        .multilineTextAlignment(.center)
    }
    
    func isValidName(valid: String) -> Bool {
        let justLettersRegex = "[^A-Za-zÀ-ÖØ-öø-ÿ]"
        return valid.isEmpty == false && valid.range(of: justLettersRegex, options: .regularExpression) == nil
    }
}


#Preview {
    SignUpEmailView(showSignInView: .constant(true))
}
