//
//  WelcomeView4.swift
//  You
//
//  Created by Oliver Gilcher on 1/26/25.
//

import SwiftUI

// App-setup View that handles App purchase subscription
struct WelcomeView4 : View {
    @Environment(\.dismiss) private var dismiss // Dismiss view
    @AppStorage("backgroundColor") var backgroundColor: String? // Appstorage value for background color
    
    @State private var isAnnual: Bool = true // Conditional for subscription period
    private var switcherHeight: CGFloat = 30 // Height for annual/monthly switcher
    private var switcherWidth: CGFloat = 150 // Width for annual/monthly switcher
    private var switcherRadius: CGFloat = 10 // Corner radius for annual/monthly switcher
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 20) { // Title
                VStack {
                    Text("How your trial works")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                    Text("First 14 days free, then \(isAnnual ? "$79.99/year ($6.67/month)" : "$9.99/month")")
                        .font(.system(size: 16))
                        .foregroundStyle(.white.opacity(0.8))
                }
                
                HStack { // Subtitle
                    // Annual option
                    Button { isAnnual = true } label: {
                        Text("Annual")
                    }
                    .frame(width: switcherWidth/2, height: switcherHeight)
                    .background(isAnnual ? Color.white.opacity(0.4) : Color.clear)
                    .clipShape(.rect(cornerRadius: switcherRadius))
                    
                    // Monthly option
                    Button { isAnnual = false } label: {
                        Text("Monthly")
                    }
                    .frame(width: switcherWidth/2, height: switcherHeight)
                    .background(!isAnnual ? Color.white.opacity(0.4) : Color.clear)
                    .clipShape(.rect(cornerRadius: switcherRadius))
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: switcherWidth, height: switcherHeight)
                .clipShape(.rect(cornerRadius: switcherRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: switcherRadius)
                        .stroke(.white.quinary, lineWidth: 2)
                )
                
                SubscriptionInfoGraphic() // Infographic for trial process
                
                Button { // Restore purchases action
                    // TODO: Restoration of App purchases
                } label: {
                    Text("Restore purchase")
                        .font(.system(size: 13))
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                VStack { // Subscribe action
                    Text("Cancel anytime in the App Store")
                    Button(
                        action: {
                            // TODO: App purchases
                        },
                        label: {
                            Text("Try for $0.00")
                        }
                    )
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .frame(width: 350, height: 55)
                    .background(.blue)
                    .clipShape(.capsule)
                }
                
                NavigationLink( // Optional, no thanks button
                    destination: WelcomeView5().navigationBarBackButtonHidden(true),
                    label: {
                        Text("No thanks.")
                    }
                )
                .foregroundStyle(.white.opacity(0.8))
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: { Image(systemName: "chevron.left") })
                        .foregroundStyle(.white)
                }
                ToolbarItemGroup(placement: .principal) {
                    ProgressView(value: 4, total: 6)
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

// Visual representation of the trial period and it's process
struct SubscriptionInfoGraphic : View {
    var body : some View {
        HStack (spacing: 20) {
            ZStack (alignment: .top) {
                VStack { // Faded rectangle
                    Rectangle()
                        .fill(LinearGradient(colors: [.yellow, .black], startPoint: .top, endPoint: .bottom))
                }
                .padding(.top)
                .frame(width: 15, height: 250)
                
                VStack (spacing: 40) { // Icons
                    Image(systemName: "lock.open.fill")
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.black)
                        .background(.yellow)
                        .clipShape(Circle())
                    Image(systemName: "bell.fill")
                        .rotationEffect(Angle(degrees: -20))
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.black)
                        .background(.yellow)
                        .clipShape(Circle())
                    Image(systemName: "star.fill")
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.black)
                        .background(.yellow)
                        .clipShape(Circle())
                }
                .font(.system(size: 14, weight: .bold))
            }
            
            VStack (spacing: 25) { // Text to the right of the icons
                VStack {
                    Text("Today")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Unlock acccess to the full library")
                        .foregroundStyle(.white.opacity(0.4))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("that we can provide you.")
                        .foregroundStyle(.white.opacity(0.4))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack {
                    Text("In 12 days")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("We'll send you a reminder that your trial")
                        .foregroundStyle(.white.opacity(0.4))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("is ending soon.")
                        .foregroundStyle(.white.opacity(0.4))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                VStack {
                    Text("In 14 days")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("You'll be charged, cancel anytime")
                        .foregroundStyle(.white.opacity(0.4))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("before.")
                        .foregroundStyle(.white.opacity(0.4))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WelcomeView4()
    }
}
