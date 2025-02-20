//
//  WelcomeView1.swift
//  You
//
//  Created by Oliver Gilcher on 1/23/25.
//

import SwiftUI

// App-setup View that handles Auth & Starts setup process
struct WelcomeView1 : View {
    @State var showSignInView : Bool = false // Conditional on Auth state
    
    // Emoji values
    let wavingHand = "👋"
    let alex = "🦊"
    
    var body : some View {
        NavigationView {
            VStack (spacing: 40) {
                // TODO: Replace with image of Alex
                Text("\(alex)")
                    .font(.system(size: 100))
                
                VStack { // Title
                    Text("Welcome to You! \(wavingHand)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.system(size: 25, weight: .bold))
                
                VStack (spacing: 5) { // Subtitle
                    Text("Hi there! I'm Alex, your personal guide.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("I'm here to help you stay on track,")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("feel your best, and achieve your goals.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Let's make this app feel like home to you!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.system(size: 18))
                .foregroundStyle(.white.opacity(0.8))
                
                Spacer()
                
                NavigationLink( // Continue button
                    destination: WelcomeView2().navigationBarBackButtonHidden(true),
                    label: {
                        Text("Let's Get Started!")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(width: 350, height: 55)
                            .background(.blue)
                            .clipShape(.capsule)
                    }
                )
            }
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    ProgressView(value: 1, total: 6)
                        .progressViewStyle(CustomProgressViewStyle(height: 15))
                        .frame(width: 300)
                }
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.voidBlack.gradient)
            .fullScreenCover(isPresented: $showSignInView) { // cover for if auth isn't handled
                NavigationStack {
                    AuthenticationView(showSignInView: $showSignInView)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WelcomeView1()
    }
}
