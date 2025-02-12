//
//  ColorExtension.swift
//  You
//
//  Created by Oliver Gilcher on 1/26/25.
//

import SwiftUI

extension Color {
    
    static func fromString(from name: String?) -> Color {
        guard let colorName = name else {return Color.voidBlack}
        
        switch colorName {
            
        // Background Colors
        case "voidBlack":
            return Color(.voidBlack)
        case "forestGreen":
            return Color(.forestGreen)
        case "sunriseOrange":
            return Color(.sunriseOrange)
        case "sereneTeal":
            return Color(.sereneTeal)
        case "crimsonRed":
            return Color(.crimsonRed)
        case "lavenderMist":
            return Color(.lavenderMist)
            
        // App Category Colors
        case "lushForest":
            return Color(.lushForest)
        case "slateGray":
            return Color(.slateGray)
            
        default:
            return Color(.black)
        }
    }
}
