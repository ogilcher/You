//
//  WelcomeView5.swift
//  You
//
//  Created by Oliver Gilcher on 1/26/25.
//

import SwiftUI

struct WelcomeView5 : View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("backgroundColor") var backgroundColor: String?
    @AppStorage("isWelcomeOver") var isWelcomeOver = false
    
    var body : some View {
        NavigationStack {
            VStack (spacing: 20) {
                
                // TODO: Once App is in BETA, add notifications
                
//                Image(systemName: "bell.fill")
//                Text("Turn on notifications to get the")
//                Text("most out of You")
//                
//                HStack {
//                    VStack {
//                        Text("Stay updated")
//                        Text("Support, inspiration, and reminders to keep")
//                        Text("your best foot foward.")
//                    }
//                    
//                }

                NavigationLink(
                    destination: ContentView().navigationBarBackButtonHidden(true),
                    label: {
                        Text("Finish")
                            .fontWeight(.semibold)
                    }
                )
                .frame(width: 350, height: 55)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.capsule)
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        DispatchQueue.main.async {
                            isWelcomeOver = true
                        }
                    }
                )
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: { Image(systemName: "chevron.left") })
                        .foregroundStyle(.white)
                }
                ToolbarItemGroup(placement: .principal) {
                    ProgressView(value: 5, total: 6)
                        .progressViewStyle(CustomProgressViewStyle(height: 15))
                        .frame(width: 300)
                }
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.fromString(from: backgroundColor ?? "voidBlack").gradient)
        }
    }
}

#Preview {
    NavigationStack {
        WelcomeView5()
    }
}
