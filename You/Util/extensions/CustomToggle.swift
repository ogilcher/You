//
//  CustomToggle.swift
//  You
//
//  Created by Oliver Gilcher on 1/29/25.
//

import SwiftUI

struct CustomToggle: View {
    @Binding var isOn: Bool
    
    @State var leftText: String
    @State var rightText: String
    
    @State var backgroundColor: Color
    @State var selectedColor: Color
    
    @State var width: CGFloat
    @State var height: CGFloat
    
    var body: some View {
        VStack {
            Text(isOn.description) // Debugging output
            
            ZStack {
                Capsule()
                    .fill(backgroundColor)
                    .overlay(
                        Capsule()
                            .stroke(isOn ? .gray : .black, lineWidth: 3)
                    )
                    .frame(width: width, height: height)
                
                HStack {
                    Text(leftText)
                        .frame(maxWidth: .infinity)
                        .onTapGesture { isOn = true }
                    
                    Text(rightText)
                        .frame(maxWidth: .infinity)
                        .onTapGesture { isOn = false }
                }
                .foregroundColor(.white)
                
                Capsule()
                    .fill(selectedColor)
                    .frame(width: width / 2, height: height)
                    .offset(x: isOn ? width / 4 : -width / 4) // Dynamically adjust offset
                    .animation(.easeOut(duration: 0.3), value: isOn)
            }
        }
    }
}

#Preview {
    CustomToggle(isOn: .constant(true), leftText: "ON", rightText: "OFF", backgroundColor: Color.black, selectedColor: Color.gray.opacity(0.4), width: 200, height: 50)
}
