//
//  WelcomeViewUtil.swift
//  You
//
//  Created by Oliver Gilcher on 1/23/25.
//

import SwiftUI

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
