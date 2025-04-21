//
//  WelcomeViewUtil.swift
//  You
//
//  Created by Oliver Gilcher on 1/23/25.
//

import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    var height: CGFloat
    var maxWidth: CGFloat = 300 // Define a max width for flexibility

    func makeBody(configuration: Configuration) -> some View {
        let progress = min(max(configuration.fractionCompleted ?? 0, 0), 1) // Ensure it's between 0 and 1
        let progressWidth = progress * maxWidth

        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height / 2)
                .frame(width: maxWidth, height: height)
                .foregroundStyle(.gray.opacity(0.3))

            RoundedRectangle(cornerRadius: height / 2)
                .frame(width: progressWidth, height: height)
                .foregroundStyle(.white)
        }
        .frame(width: maxWidth, height: height)
    }
}

struct ColoredCustomProgressViewStyle: ProgressViewStyle {
    var height: CGFloat
    var width: CGFloat
    
    var baseColor: Color
    var frontColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = min(max(configuration.fractionCompleted ?? 0, 0), 1) // Ensure it's beween 0 and 1
        let progressWidth = progress * width
        
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height / 2)
                .frame(width: width, height: height)
                .foregroundStyle(baseColor)
            RoundedRectangle(cornerRadius: height / 2)
                .frame(width: progressWidth, height: height)
                .foregroundStyle(frontColor)
        }
    }
}
