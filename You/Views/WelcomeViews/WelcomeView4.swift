//
//  WelcomeView4.swift
//  You
//
//  Created by Oliver Gilcher on 1/26/25.
//

import SwiftUI

struct WelcomeView4 : View {
    @AppStorage("backgroundColor") var backgroundColor: String = "voidBlack"
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 40) {
                WelcomeViewHeader(previousView: AnyView(WelcomeView3()), currentIndex: 3)
                    .padding(.top, 100)
                
                Text("What's your favorite color style? \nBright and bold? Cool or warm? You pick, I'll make it shine!")
                    .padding()
                    .frame(
                        width: 350,
                        height: 110
                    )
                    .background(.white.quinary)
                    .clipShape(.rect(cornerRadius: 25))
                    .multilineTextAlignment(.center)
                
                HStack (spacing: 20) {
                    backgroundColorCard(color: "voidBlack", backgroundColor: $backgroundColor)
                    backgroundColorCard(color: "sunriseOrange", backgroundColor: $backgroundColor)
                    backgroundColorCard(color: "forestGreen", backgroundColor: $backgroundColor)
                }
                
                HStack (spacing: 20) {
                    backgroundColorCard(color: "sereneTeal", backgroundColor: $backgroundColor)
                    backgroundColorCard(color: "crimsonRed", backgroundColor: $backgroundColor)
                    backgroundColorCard(color: "lavenderMist", backgroundColor: $backgroundColor)
                }
                
                NavigationLink(
                    destination: WelcomeView5().navigationBarBackButtonHidden(true),
                    label: {
                        Text("Continue")
                            .frame(
                                width: 150,
                                height: 55
                            )
                            .background(.blue)
                            .clipShape(.capsule)
                            .padding(.top, 50)
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
            .background(Color.fromString(from: backgroundColor).gradient)
            .ignoresSafeArea()
        }
    }
}

struct backgroundColorCard : View {
    var color: String
    @Binding var backgroundColor : String
    
    var body : some View {
        Button (
            action: {
                backgroundColor = color
            },
            label: {
                VStack {
                    if backgroundColor.elementsEqual(color) {
                        Image(systemName: "checkmark")
                    }
                }
                .frame(width: 100, height: 150)
                .background(Color.fromString(from: color))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 1)
                )
                .foregroundStyle(.white)
            }
        )
    }
}

#Preview {
    WelcomeView4()
}
