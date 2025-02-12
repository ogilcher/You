//
//  WelcomeView3.swift
//  You
//
//  Created by Oliver Gilcher on 1/26/25.
//

import SwiftUI

struct WelcomeView3 : View {
    @AppStorage("username") var userName: String?
    let alex = "🦊"
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 40) {
                WelcomeViewHeader(previousView: AnyView(WelcomeView2()), currentIndex: 2)
                    .padding(.top, 100)
                
                Text("\(alex)") // TODO: Replace with image of Alex
                    .font(.system(size: 100))
                
                Text("Now let's personalize your experience, what is your name?")
                    .padding()
                    .frame(
                        width: 350,
                        height: 100
                    )
                    .background(.white.quinary)
                    .clipShape(.rect(cornerRadius: 25))
                    .multilineTextAlignment(.center)
                
                TextField("Jhon", text: Binding(
                    get: { userName ?? "" },
                    set: { userName = $0 }
                ))
                .autocorrectionDisabled(true)
                
                .frame(width: 350)
                .background(Color.gray.opacity(0.4))
                .clipShape(
                    RoundedRectangle(cornerRadius: 8)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white, lineWidth: 1)
                )
                
                NavigationLink(
                    destination: WelcomeView4().navigationBarBackButtonHidden(true),
                    label: {
                        Text("Continue")
                            .frame(
                                width: 150,
                                height: 55
                            )
                            .background(.blue)
                            .clipShape(.capsule)
                            .padding(.top, 100)
                    }
                )
                
                Spacer()
            }
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.white)
            .padding()
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(Color.fromString(from: "voidBlack").gradient)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WelcomeView3()
}
