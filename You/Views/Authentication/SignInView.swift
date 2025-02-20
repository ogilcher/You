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
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}

final class SignInFocusables: ObservableObject {
    enum FocusableField: Hashable, CaseIterable {
        case email, password
    }
}

struct SignInView : View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SignInViewModel()
    @Binding var showSignInView : Bool
    
    @FocusState private var focusedField: SignInFocusables.FocusableField?
    
    var body : some View {
        NavigationStack {
            ZStack (alignment: .center) {
                VStack (spacing: 20) {
                    // Email and Password Text Fields
                    formattedSignInEmailField(desiredValue: "Email address", viewModelValue: $viewModel.email, focusedField: $focusedField, focusableValue: SignInFocusables.FocusableField.email, parent: self)
                    formattedSignInPasswordField(desiredValue: "Password", viewModelValue: $viewModel.password, focusedField: $focusedField, focusableValue: SignInFocusables.FocusableField.password, parent: self)
                    
                    NavigationLink(
                        destination: self.navigationBarBackButtonHidden(),
                        label: {
                            Text("Forgot password?")
                                .foregroundStyle(.yellow)
                                .font(.system(size: 14, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    )
                    .padding(.horizontal, 15)
                    
                    Button(
                        action: {
                            submit()
                        },
                        label: {
                            Text("Log in")
                        }
                    )
                    .fontWeight(.semibold)
                    .foregroundStyle(viewModel.email.isEmpty || viewModel.password.isEmpty ? .white.opacity(0.4) : .white)
                    .frame(width: 350, height: 55)
                    .background(viewModel.email.isEmpty || viewModel.password.isEmpty ? .blue.opacity(0.4) : .blue)
                    .clipShape(.rect(cornerRadius: 40))
                    
                    Text("or")
                        .font(.system(size: 18))
                        .foregroundStyle(.gray)
                    
                    HStack { // Alternative sign-up option (e.g., Apple Sign-In)
                        Image(systemName: "apple.logo")
                            .foregroundStyle(Color(uiColor: UIColor.systemBackground))
                            .frame(width: 45, height: 45)
                            .background(.primary)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.voidBlack.gradient)
            .navigationTitle("Log in")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    
                    Button(action: { dismiss() }, label: { Image(systemName: "chevron.left") })
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    func focusNextField() {
        switch focusedField {
        case .email: focusedField = .password
        case .password: focusedField = nil
        case .none:  break
        }
    }
    
    func submit() {
        Task {
            do {
                try await viewModel.signIn()
                showSignInView = false
            } catch {
                print(error)
            }
        }
    }
}

struct formattedSignInEmailField : View {
    var desiredValue: String
    @Binding var viewModelValue: String
    var focusedField: FocusState<SignInFocusables.FocusableField?>.Binding
    var focusableValue: SignInFocusables.FocusableField
    var parent: SignInView
    
    var body: some View {
        HStack {
            VStack {
                if !viewModelValue.isEmpty {
                    Text(desiredValue)
                        .font(.system(size: 10))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                TextField(desiredValue, text: $viewModelValue)
                    .focused(focusedField, equals: focusableValue)
                    .keyboardType(.emailAddress)
                    .submitLabel(.next)
                    .font(.system(size: 16, weight: .semibold))
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .onSubmit {
                        parent.focusNextField()
                    }
            }
        }
        .padding()
        .frame(width: 350, height: 50)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(focusedField.wrappedValue == focusableValue ? Color.white : Color.white.opacity(0.4), lineWidth: 2)
        )
    }
}

struct formattedSignInPasswordField : View {
    var desiredValue: String
    @Binding var viewModelValue: String
    var focusedField: FocusState<SignInFocusables.FocusableField?>.Binding
    var focusableValue: SignInFocusables.FocusableField
    var parent: SignInView
    
    @State private var isPasswordRevealed: Bool = false
    
    var body: some View {
        HStack {
            VStack {
                if !viewModelValue.isEmpty {
                    Text(desiredValue)
                        .font(.system(size: 10))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Group {
                    if isPasswordRevealed {
                        TextField(desiredValue, text: $viewModelValue)
                            .focused(focusedField, equals: focusableValue)
                            .font(.system(size: 16, weight: .semibold))
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .onSubmit {
                                parent.submit()
                            }
                    } else {
                        SecureField(desiredValue, text: $viewModelValue)
                            .focused(focusedField, equals: focusableValue)
                            .font(.system(size: 16, weight: .semibold))
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .onSubmit {
                                parent.submit()
                            }
                    }
                }
            }
            Spacer()
            Button { isPasswordRevealed.toggle() } label: {
                Image(systemName: isPasswordRevealed ? "eye.slash" : "eye")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15, weight: .bold))
            }
        }
        .padding()
        .frame(width: 350, height: 50)
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(focusedField.wrappedValue == focusableValue ? Color.white : Color.white.opacity(0.4), lineWidth: 2)
        )
    }
}


#Preview {
    NavigationStack {
        SignInView(showSignInView: .constant(true))
    }
}
