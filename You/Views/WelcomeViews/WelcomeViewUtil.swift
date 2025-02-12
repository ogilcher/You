//
//  WelcomeViewUtil.swift
//  You
//
//  Created by Oliver Gilcher on 1/23/25.
//

import SwiftUI

struct WelcomeViewHeader : View {
    var previousView : AnyView?
    var currentIndex : Int
    
    var body : some View {
        HStack {
            NavigationLink(
                destination: previousView?.navigationBarBackButtonHidden(true),
                label: {
                    Image(systemName: "chevron.left")
                }
            )
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
            
            ProgressView(value: Double(currentIndex), total: 6)
            .progressViewStyle(CustomProgressViewStyle(height:15)) // Custom height
            .frame(width: 350) // Fixed width
                
                
        }
    }
}

struct CustomProgressViewStyle: ProgressViewStyle {
    var height: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer() // Center the progress bar horizontally
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height / 2)
                    .frame(height: height) // Set the desired height
                    .foregroundColor(.gray.opacity(0.3))
                
                RoundedRectangle(cornerRadius: height / 2)
                    .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 300, height: height) // Adjust width based on progress
                    .foregroundColor(.white) // Tint color of the progress bar
            }
            
            Spacer() // Center the progress bar horizontally
        }
        .frame(height: height) // Ensure the whole container doesn't exceed the defined height
    }
}

#Preview {
    WelcomeViewHeader(previousView: AnyView(WelcomeView1()), currentIndex: 3)
}
