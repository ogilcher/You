//
//  WelcomeView2.swift
//  You
//
//  Created by Oliver Gilcher on 1/23/25.
//

import SwiftUI


struct WelcomeView2 : View {
    let alex = "🦊"
    
    @State var fName : String = ""
    @State var lName : String = ""
    
    @State private var showingPassword = false
    @State var didAuthenticate : Bool = false
    @State var showSignInView : Bool = false
    
    var body : some View {
        NavigationView {
            VStack {
                WelcomeViewHeader(previousView: AnyView(WelcomeView1()), currentIndex: 1)
                    .padding(.top, 100)
                
                HStack {
                    
                    Text("\(alex)") // TODO: Replace with image of Alex
                        .font(.system(size: 100))
                    
                    Text("First, let's get you an account set up with us!")
                        .padding()
                        .frame(
                            width: 200,
                            height: 150
                        )
                        .background(.white.quinary)
                        .clipShape(.rect(cornerRadius: 25))
                        .multilineTextAlignment(.center)
                }
                
                if !didAuthenticate {
                    Button (
                        action: {
                            showSignInView = true
                            didAuthenticate = true
                        },
                        label: {
                            Text("Let's get started!")
                                .frame(width: 250, height: 55)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(.rect(cornerRadius: 20))
                        }
                    )
                } else {
                    NavigationLink(
                        destination: WelcomeView3().navigationBarBackButtonHidden(),
                        label: {
                            Text("Continue")
                                .frame(width: 250, height: 55)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(.rect(cornerRadius: 20))
                        }
                    )
                }
                
                Spacer()
            }
            .fullScreenCover(isPresented: $showSignInView) {
                NavigationStack {
                    AuthenticationView(showSignInView: $showSignInView)
                }
            }
            
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
            .padding()
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(Color.fromString(from: "voidBlack").gradient) // TODO: Make the custom color (dark blue)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WelcomeView2()
}
