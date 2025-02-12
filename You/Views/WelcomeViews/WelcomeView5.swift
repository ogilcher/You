//
//  WelcomeView5.swift
//  You
//
//  Created by Oliver Gilcher on 1/26/25.
//

import SwiftUI

struct WelcomeView5 : View {
    @AppStorage("backgroundColor") var backgroundColor: String?
    @AppStorage("isWelcomeOver") var isWelcomeOver : Bool?
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 20) {
                WelcomeViewHeader(previousView: AnyView(WelcomeView4()), currentIndex: 4)
                    .padding(.top, 100)
                
                Text("How may I be of your assistance? \n\nPlease choose up to 10 categories. \nYou can always change your preferences later!")
                    .padding()
                    .frame(
                        width: 375,
                        height: 175
                    )
                    .background(.white.quinary)
                    .clipShape(.rect(cornerRadius: 25))
                    .multilineTextAlignment(.center)
                
                ScrollView {
                    // TODO: use app storage to save preferences to Firebase
                }
                
                NavigationLink(
                    destination: ContentView().navigationBarBackButtonHidden(),
                    label: {
                        Text("Finish")
                            .frame(
                                width: 150,
                                height: 55
                            )
                            .background(.blue)
                            .clipShape(.capsule)
                            .padding(.top, 50)
                            .padding(.bottom, 50)
                    }
                )
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        Task {
                            // Save the user's category preferences
                            isWelcomeOver = true
                        }
                    }
                )
            }
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.white)
            .padding()
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(Color.fromString(from: backgroundColor).gradient)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WelcomeView5()
}
