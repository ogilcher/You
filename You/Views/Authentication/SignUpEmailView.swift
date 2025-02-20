//
//  SignUpEmailView.swift
//  You
//
//  Created by Oliver Gilcher on 1/24/25.
//

// TODO: Add Terms & Conditions, Privacy Policy & Keychain functionality

import SwiftUI

// ViewModel for handling sign-up logic
@MainActor
final class SignUpEmailViewModel: ObservableObject {
    @Published var fName = ""      // First name
    @Published var lName = ""      // Last name
    @Published var email = ""      // Email address
    @Published var password = ""   // User password

    // Sign-up function using asynchronous Firebase calls
    func signUp() async throws {
        print("First Name:", fName)
        print("Last Name:", lName)
        print("Email:", email)
        print("Password:", password)
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
        print("User UID:", authDataResult.uid)
    }
}

// Focusable fields for sign-up form
final class SignUpFocusables: ObservableObject {
    enum FocusableField: Hashable, CaseIterable {
        case firstName, lastName, email, password
    }
}

// Main sign-up view for email registration
struct SignUpEmailView: View {
    @Environment(\.dismiss) private var dismiss   // Dismiss view
    @StateObject private var viewModel = SignUpEmailViewModel()   // ViewModel instance
    @Binding var showSignInView: Bool              // Binding to control sign-in view display

    @FocusState private var focusedField: SignUpFocusables.FocusableField?  // Currently focused field
    @State private var isUniqueAccount: Bool = true  // Flag for unique email check
    @State private var signInProcessSuccess: Bool = true  // Flag for sign-up success
    @State private var isValuesValid: Bool = true
    @State private var isShowingError: Bool = false
    @State private var showingPasswordInstructions: Bool = false  // Flag to show password guidelines

    var body: some View {
        NavigationStack {
            ZStack (alignment: .center) {
                ScrollView {
                    VStack (spacing: 20) {
                        Text("Welcome to You")
                            .font(.system(size: 20, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.white)
                        
                        Text("Create an account to access financial tools, mental health resources, and more.")
                            .font(.system(size: 15))
                            .foregroundStyle(.white.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        formattedTextField(
                            desiredValue: "First name",
                            focusableValue: .firstName,
                            focusedField: $focusedField,
                            viewModelValue: $viewModel.fName,
                            validator: isValidName,
                            isValuesValid: $isValuesValid,
                            parent: self
                        )
                        formattedTextField(
                            desiredValue: "Last name",
                            focusableValue: .lastName,
                            focusedField: $focusedField,
                            viewModelValue: $viewModel.lName,
                            validator: isValidName,
                            isValuesValid: $isValuesValid,
                            parent: self
                        )
                        formattedTextField(
                            desiredValue: "Email address",
                            focusableValue: .email,
                            focusedField: $focusedField,
                            viewModelValue: $viewModel.email,
                            validator: isValidEmail,
                            isValuesValid: $isValuesValid,
                            parent: self
                        )
                        formattedPasswordField(
                            desiredValue: "Password (8+ characters)",
                            focusableValue: .password,
                            focusedField: $focusedField,
                            viewModelValue: $viewModel.password,
                            validator: isValidPassword,
                            isValuesValid: $isValuesValid,
                            parent: self
                        )
                        
                        if focusedField == .password { // Show password instructions when password field is focused
                            VStack {
                                Text("An 8 character password is required, with at least 3 of the following:\n· 1 lower-case character\n· 1 upper-case character\n· 1 number\n· 1 special character")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            .frame(width: 350, height: 120)
                            .font(.system(size: 12))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(.white.quinary, lineWidth: 1))
                        }
                        
                        VStack (spacing: 0) {
                            HStack(spacing: 0) { // Terms & Conditions
                                Text("By continuing, you agree to You's ")
                                Button(action: { /* TODO: Terms action */ }, label: {
                                    Text("Terms & Conditions").foregroundStyle(.yellow)
                                })
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 12))
                            .foregroundStyle(.white.opacity(0.8))
                            
                            HStack(spacing: 0) { // Privacy Policy
                                Text("and ")
                                Button(action: { /* TODO: Privacy action */ }, label: {
                                    Text("Privacy Policy").foregroundStyle(.yellow)
                                })
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 12))
                            .foregroundStyle(.white.opacity(0.8))
                        }
                        
                        Button { // Continue button
                            submit()
                        } label: {
                            Text("Continue")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: 350, height: 55)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                                .padding(.top, 20)
                        }
                        
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
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 25)
                }
                .scrollIndicators(.hidden)
                
                // Error Message Handling:
                if isShowingError {
                    VStack {
                        VStack {
                            if !isValuesValid {
                                Text("It looks like some information is missing or incorrect.")
                                    .font(.system(size: 20, weight: .semibold))
                                    .padding(.bottom, 20)
                                if viewModel.fName.isEmpty {
                                    Text("· First Name is required.")
                                }
                                if viewModel.lName.isEmpty {
                                    Text("· Last Name is required.")
                                }
                                if viewModel.email.isEmpty {
                                    Text("· Email Address is required.")
                                }
                                if viewModel.password.isEmpty {
                                    Text("· Password is required.")
                                }
                                if !isValidName(valid: viewModel.fName) {
                                    Text("· Your first name cannot contain any special characters.")
                                }
                                if !isValidName(valid: viewModel.lName) {
                                    Text("· Your last name cannot contain any special characters..")
                                }
                                if !isValidEmail(valid: viewModel.email) {
                                    Text("· Your email address is not in the correct format.")
                                }
                                if !isValidPassword(valid: viewModel.password) {
                                    Text("· Your password is not in the correct format.")
                                }
                            } else if !signInProcessSuccess {
                                Text("Something went wrong...")
                                    .font(.system(size: 20, weight: .semibold))
                                Text("Please try again later.")
                                    .font(.system(size: 20, weight: .semibold))
                            } else if !isUniqueAccount {
                                Text("An account under this email already exists.")
                                    .font(.system(size: 20, weight: .semibold))
                                Text("Please log in or try a different email.")
                                    .font(.system(size: 20, weight: .semibold))
                            }
                        }
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button (
                            action: {
                                isShowingError = false
                            },
                            label: {
                                Text("Ok")
                            }
                        )
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 200, height: 55)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 40))
                    }
                    .frame(width: 350)
                    .padding()
                    .background(.voidBlack)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white.quinary, lineWidth: 1)
                    }
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: { Image(systemName: "chevron.left") })
                        .foregroundStyle(.white)
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    HStack(spacing: 0) {
                        Text("Already have an account?")
                        NavigationLink(
                            destination: SignInView(showSignInView: $showSignInView).navigationBarBackButtonHidden(),
                            label: { Text("Log in").foregroundStyle(.yellow) }
                        )
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.gray)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.fromString(from: "voidBlack").gradient)
        }
    }
    
    func hasErrors() -> Bool {
        if viewModel.fName.isEmpty && viewModel.lName.isEmpty && viewModel.email.isEmpty && viewModel.password.isEmpty && !isValidName(valid: viewModel.fName) && !isValidName(valid: viewModel.lName) && !isValidEmail(valid: viewModel.email) && !isValidPassword(valid: viewModel.password) {
            return true
        } else {
            return false
        }
    }
    
    // Move focus to the next field based on current focus
    func focusNextField() {
        switch focusedField {
        case .firstName: focusedField = .lastName
        case .lastName: focusedField = .email
        case .email: focusedField = .password
        case .password: focusedField = nil
        case .none: break
        }
    }
    
    func submit() {
        if isValuesValid || !hasErrors() {
            Task {
                do {
                    try await viewModel.signUp()
                    showSignInView = false
                } catch {
                    if error.localizedDescription == "The email address is already in use by another account." {
                        isUniqueAccount = false
                        isShowingError = true
                    } else {
                        signInProcessSuccess = false
                        isShowingError = true
                    }
                }
            }
        } else {
            isShowingError = true
        }
    }
    
    // Validate name input (letters only)
    private func isValidName(valid: String) -> Bool {
        let justLettersRegex = "[^A-Za-zÀ-ÖØ-öø-ÿ]"
        return !valid.isEmpty && valid.range(of: justLettersRegex, options: .regularExpression) == nil
    }
    
    // Validate email format using regex
    private func isValidEmail(valid: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: valid)
    }
    
    // Validate password complexity using regex
    private func isValidPassword(valid: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*(),.?\":{}|<>])[A-Za-z\\d!@#$%^&*(),.?\":{}|<>]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: valid)
    }
}

// Reusable text field view with validation
struct formattedTextField: View {
    var desiredValue: String
    var focusableValue: SignUpFocusables.FocusableField
    var focusedField: FocusState<SignUpFocusables.FocusableField?>.Binding
    @Binding var viewModelValue: String
    var validator: (String) -> Bool
    @Binding var isValuesValid: Bool
    var parent: SignUpEmailView
    
    var body: some View {
        HStack {
            VStack {
                if !viewModelValue.isEmpty {
                    Text("\(desiredValue)*") // Label when text exists
                        .font(.system(size: 10))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                TextField("\(desiredValue)*", text: $viewModelValue, onEditingChanged: { _ in
                    if !validator(viewModelValue) {
                        isValuesValid = false
                    }
                })
                    
                    .keyboardType(focusableValue == SignUpFocusables.FocusableField.email ? .emailAddress : .default)
                    .submitLabel(.next)
                    .font(.system(size: 16, weight: .semibold))
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused(focusedField, equals: focusableValue)
                    .onSubmit {
                        if validator(viewModelValue) {
                            parent.focusNextField()
                        }
                    }
            }
            Spacer()
            if validator(viewModelValue) {
                Image(systemName: "checkmark") // Valid input feedback
                    .foregroundStyle(.green)
                    .font(.system(size: 15, weight: .bold))
            } else if !viewModelValue.isEmpty {
                Image(systemName: "xmark") // Invalid input feedback
                    .foregroundStyle(.red)
                    .font(.system(size: 15, weight: .bold))
            }
        }
        .padding()
        .frame(width: 350, height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.clear)
                .stroke(focusedField.wrappedValue == focusableValue ? Color.white : Color.white.opacity(0.4), lineWidth: 2)
        )
    }
}

// Reusable password field view with reveal option and validation
struct formattedPasswordField: View {
    var desiredValue: String
    var focusableValue: SignUpFocusables.FocusableField
    var focusedField: FocusState<SignUpFocusables.FocusableField?>.Binding
    @Binding var viewModelValue: String
    var validator: (String) -> Bool
    @Binding var isValuesValid: Bool
    var parent: SignUpEmailView
    
    @State private var isPasswordRevealed: Bool = false
    
    var body: some View {
        HStack {
            VStack {
                if !viewModelValue.isEmpty {
                    Text("\(desiredValue)*")
                        .font(.system(size: 10))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Group {
                    if isPasswordRevealed {
                        TextField("\(desiredValue)*", text: $viewModelValue)
                    } else {
                        SecureField("\(desiredValue)*", text: $viewModelValue)
                    }
                }
                .font(.system(size: 16, weight: .semibold))
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .focused(focusedField, equals: focusableValue)
                .onSubmit {
                    if validator(viewModelValue) {
                        parent.submit()
                    }
                }
            }
            Spacer()

            if validator(viewModelValue) {
                Image(systemName: "checkmark")
                    .foregroundStyle(.green)
                    .font(.system(size: 15, weight: .bold))
            } else if !viewModelValue.isEmpty {
                Image(systemName: "xmark")
                    .foregroundStyle(.red)
                    .font(.system(size: 15, weight: .bold))
            }
            
            Button { isPasswordRevealed.toggle() } label: {
                Image(systemName: isPasswordRevealed ? "eye.slash" : "eye")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15, weight: .bold))
            }
        }
        .padding()
        .frame(width: 350, height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.clear)
                .stroke(focusedField.wrappedValue == focusableValue ? Color.white : Color.white.opacity(0.4), lineWidth: 2)
        )
    }
}

#Preview {
    NavigationStack {
        SignUpEmailView(showSignInView: .constant(true))
    }
}
