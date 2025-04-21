//
//  AuthenticationView.swift
//  You
//
//  Created by Oliver Gilcher on 1/24/25.
//

import SwiftUI

struct AuthenticationView : View {
    let alex = "🦊"
    @State private var checkBoxState : Int = 0 // 0 = Not checked, 1 = Checked, 2 = Error
    @Binding var showSignInView : Bool
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 20) {
                Text("Welcome to You")
                    .font(.system(size: 40, weight: .bold))
                    .padding(.top, 50)
                Text("The extension of yourself")
                    .font(.system(size: 22, weight: .bold))
                
                Spacer()
                
                Text(alex)
                    .font(.system(size: 175))
                    .frame(width: 250, height: 250)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 150))
                
                Spacer()
                
                HStack (spacing: 20) {
                    Button (
                        action: {
                            if checkBoxState == 0 { // If unchchecked, check it
                                checkBoxState = 1
                            } else if checkBoxState == 1 { // If checkced, uncheck it
                                checkBoxState = 0
                            } else if checkBoxState == 2 { // If errored, check it
                                checkBoxState = 1
                            }
                        },
                        label: {
                            if checkBoxState == 0 { // If unchchecked
                                Image(systemName: "square")
                                    .foregroundStyle(.white)
                            } else if checkBoxState == 1 { // If checkced
                                Image(systemName: "checkmark.square")
                                    .foregroundStyle(.blue)
                            } else if checkBoxState == 2 { // If errored
                                Image(systemName: "square")
                                    .foregroundStyle(.red)
                            }
                                
                        }
                    )
                    .font(.system(size: 18, weight: .semibold))
                    
                    VStack {
                        HStack (spacing: 0) {
                            Text("I agree to You's ")
                            Button(
                                action: {
                                    // TODO: Open terms and conditions
                                },
                                label: {
                                    Text("Terms & Conditions")
                                        .underline()
                                }
                            )
                            Text(" and")
                            Spacer()
                        }
                        HStack (spacing: 0) {
                            Text("acknowledge the ")
                            Button(
                                action: {
                                    // TODO: Open the Privacy policy
                                },
                                label: {
                                    Text("Privacy Policy")
                                        .underline()
                                }
                            )
                            Text(".")
                            Spacer()
                        }
                    }
                    .font(.system(size: 13))
                }
                .frame(width: 300)
                
                Text(checkBoxState == 2 ? "Please check the box to continue" : "")
                    .font(.system(size: 13))
                    .foregroundStyle(.red)
                
                if checkBoxState != 1 {
                    Button (
                        action: {
                            checkBoxState = 2
                        },
                        label: {
                            Text("Create an account")
                                .font(.system(size: 20, weight: .semibold))
                                .frame(width: 300, height: 25)
                                .padding()
                                .foregroundColor(.white)
                                .background(.blue)
                                .clipShape(.rect(cornerRadius: 50))
                        }
                    )
                    Button (
                        action: {
                            checkBoxState = 2
                        },
                        label: {
                            Text("Log in")
                                .font(.system(size: 20, weight: .semibold))
                                .frame(width: 300, height: 25)
                                .padding()
                                .foregroundColor(.white)
                                .background(.white.quinary.opacity(0.4))
                                .clipShape(.rect(cornerRadius: 50))
                        }
                    )
                } else {
                    NavigationLink(
                        destination: SignUpView(showSignInView: $showSignInView).navigationBarBackButtonHidden(),
                        label: {
                            Text("Create an account")
                                .font(.system(size: 20, weight: .semibold))
                                .frame(width: 300, height: 25)
                                .padding()
                                .foregroundColor(.white)
                                .background(.blue)
                                .clipShape(.rect(cornerRadius: 50))
                        }
                    )
                    NavigationLink(
                        destination: SignInView(showSignInView: $showSignInView).navigationBarBackButtonHidden(),
                        label: {
                            Text("Log in")
                                .font(.system(size: 20, weight: .semibold))
                                .frame(width: 300, height: 25)
                                .padding()
                                .foregroundColor(.white)
                                .background(.white.quinary.opacity(0.4))
                                .clipShape(.rect(cornerRadius: 50))
                        }
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.fromString(from: "voidBlack").gradient)
        }

    }
}

#Preview {
    AuthenticationView(showSignInView: .constant(true))
}
