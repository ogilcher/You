//
//  SignUpView.swift
//  You
//
//  Created by Oliver Gilcher on 2/5/25.
//

import SwiftUI

struct SignUpView: View {
    @Binding var showSignInView : Bool
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 15) {
                Spacer()
    
                Text("Create an account")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.bottom, 30)
                
                NavigationLink(
                    destination: SignUpEmailView(showSignInView: $showSignInView).navigationBarBackButtonHidden(),
                    label: {
                        HStack {
                            Image(systemName: "apple.logo")
                            Text("Continue with Apple")
                        }
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 300, height: 25)
                        .padding()
                        .clipShape(.rect(cornerRadius: 50))
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(.white.quinary.opacity(0.4), lineWidth: 2)
                        )
                    }
                )
                
                NavigationLink(
                    destination: SignUpEmailView(showSignInView: $showSignInView).navigationBarBackButtonHidden(),
                    label: {
                        HStack {
                            Image(systemName: "xbox.logo")
                            Text("Continue with Xbox")
                        }
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 300, height: 25)
                        .padding()
                        .clipShape(.rect(cornerRadius: 50))
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(.white.quinary.opacity(0.4), lineWidth: 2)
                        )
                    }
                )
                
                NavigationLink(
                    destination: SignUpEmailView(showSignInView: $showSignInView).navigationBarBackButtonHidden(),
                    label: {
                        HStack {
                            Image(systemName: "playstation.logo")
                            Text("Continue with Playstation")
                        }
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 300, height: 25)
                        .padding()
                        .clipShape(.rect(cornerRadius: 50))
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(.white.quinary.opacity(0.4), lineWidth: 2)
                        )
                    }
                )
                
                NavigationLink(
                    destination: SignUpEmailView(showSignInView: $showSignInView).navigationBarBackButtonHidden(),
                    label: {
                        HStack {
                            Image(systemName: "envelope")
                            Text("Continue with Email")
                        }
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 300, height: 25)
                        .padding()
                        .clipShape(.rect(cornerRadius: 50))
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(.white.quinary.opacity(0.4), lineWidth: 2)
                        )
                    }
                )
                
                HStack (spacing: 5) {
                    Text("Already have an account? ")
                    NavigationLink(
                        destination: SignInView(showSignInView: $showSignInView).navigationBarBackButtonHidden(),
                        label: {
                            Text("Log in")
                                .foregroundStyle(.yellow)
                        }
                    )
                }
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.gray)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.fromString(from: "voidBlack").gradient)
        }
    }
}

#Preview {
    SignUpView(showSignInView: .constant(true))
}
