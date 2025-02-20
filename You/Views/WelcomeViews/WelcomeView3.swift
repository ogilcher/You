//
//  WelcomeView3.swift
//  You
//
//  Created by Oliver Gilcher on 2/19/25.
//

import SwiftUI

struct WelcomeView3 : View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("backgroundColor") var backgroundColor: String = "voidBlack"
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 20) {
                VStack {
                    Text("What's your favorite")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("color style?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.system(size: 25, weight: .bold))
                
                VStack (spacing: 5) {
                    Text("Bright or bold? Cool or warm?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("You pick, I'll make it shine!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.system(size: 16))
                .foregroundStyle(.white.opacity(0.8))
                
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
                
                Spacer()
                
                NavigationLink(
                    destination: WelcomeView4().navigationBarBackButtonHidden(),
                    label: {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .frame(width: 350, height: 55)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(.rect(cornerRadius: 45))
                    }
                )
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: { Image(systemName: "chevron.left") })
                        .foregroundStyle(.white)
                }
                ToolbarItemGroup(placement: .principal) {
                    ProgressView(value: 3, total: 6)
                        .progressViewStyle(CustomProgressViewStyle(height: 15))
                        .frame(width: 300)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.fromString(from: backgroundColor).gradient)
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
    NavigationStack {
        WelcomeView3()
    }
}
