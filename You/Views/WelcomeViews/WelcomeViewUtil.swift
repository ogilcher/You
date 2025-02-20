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
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height / 2)
                .frame(height: height)
                .foregroundColor(.gray.opacity(0.3))

            RoundedRectangle(cornerRadius: height / 2)
                .frame(width: max(CGFloat(configuration.fractionCompleted ?? 0) * 300, 0), height: height) // Ensure width doesn't go negative
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, minHeight: height) // Make it flexible
    }
}
