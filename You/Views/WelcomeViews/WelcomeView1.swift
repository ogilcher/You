//
//  WelcomeView1.swift
//  You
//
//  Created by Oliver Gilcher on 1/23/25.
//

import SwiftUI

struct WelcomeView1 : View {
    
    let wavingHand = "👋"
    let alex = "🦊"
    
    @State var showSignInView : Bool = false
    
    var body : some View {
        NavigationView {
            VStack (spacing: 40) {
                
                // TODO: Replace with image of Alex
                Text("\(alex)")
                    .font(.system(size: 100))
                
                VStack (spacing: 40) {
                    Text("Welcome to You! \(wavingHand)")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    
                    Text("Hi there! I'm Alex, your personal guide. I'm here to help you stay on track, feel your best, and achieve your goals.")
                    
                    Text("Let's make this app feel like home to you!")
                }
                .padding()
                .frame(
                    width: 350,
                    height: 300
                )
                .background(.white.quinary)
                .clipShape(.rect(cornerRadius: 25))
                
                NavigationLink(
                    destination: WelcomeView2().navigationBarBackButtonHidden(true),
                    label: {
                        Text("Let's Get Started!")
                            .frame(
                                width: 350,
                                height: 55
                            )
                            .background(.blue)
                            .clipShape(.capsule)
                            .padding(.top, 100)
                    }
                )
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    ProgressView(value: 1, total: 6)
                        .progressViewStyle(CustomProgressViewStyle(height: 15))
                        .frame(width: 300)
                }
            }
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .padding()
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(Color.fromString(from: "voidBlack").gradient) // TODO: Make the custom color (dark blue)
            .fullScreenCover(isPresented: $showSignInView) {
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
