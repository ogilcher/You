//
//  WelcomeView3.swift
//  You
//
//  Created by Oliver Gilcher on 2/19/25.
//

import SwiftUI

// App-setup View that handles App background color selection
struct WelcomeView3 : View {
    @Environment(\.dismiss) private var dismiss // Dismiss view
    @AppStorage("backgroundColor") var backgroundColor: String = "voidBlack" // Appstorage value for background color
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 20) {
                VStack { // Title
                    Text("What's your favorite")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("color style?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.system(size: 25, weight: .bold))
                
                VStack (spacing: 5) { // Subtitle
                    Text("Bright or bold? Cool or warm?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("You pick, I'll make it shine!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.system(size: 18))
                .foregroundStyle(.white.opacity(0.8))
                
                HStack (spacing: 20) { // First row of colors
                    backgroundColorCard(color: "voidBlack", backgroundColor: $backgroundColor)
                    backgroundColorCard(color: "sunriseOrange", backgroundColor: $backgroundColor)
                    backgroundColorCard(color: "forestGreen", backgroundColor: $backgroundColor)
                }
                
                HStack (spacing: 20) { // Second row of colors
                    backgroundColorCard(color: "sereneTeal", backgroundColor: $backgroundColor)
                    backgroundColorCard(color: "crimsonRed", backgroundColor: $backgroundColor)
                    backgroundColorCard(color: "lavenderMist", backgroundColor: $backgroundColor)
                }
                
                Spacer()
                
                NavigationLink( // Continue button
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
                // Back button
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: { Image(systemName: "chevron.left") })
                        .foregroundStyle(.white)
                }
                // Custom progress bar
                ToolbarItemGroup(placement: .principal) {
                    ProgressView(value: 3, total: 6)
                        .progressViewStyle(CustomProgressViewStyle(height: 15))
                        .frame(width: 300)
                }
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.fromString(from: backgroundColor).gradient)
        }
    }
}

// Custom card for background color selection
struct backgroundColorCard : View {
    var color: String // param: color name that we are using
    @Binding var backgroundColor : String // param: ref to AppStorage background color
    
    var body : some View {
        Button { backgroundColor = color } label: {
            VStack {
                if backgroundColor.elementsEqual(color) {
                    Image(systemName: "checkmark") // display a checkmark is the user selected this value
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
    }
}

#Preview {
    NavigationStack {
        WelcomeView3()
    }
}
