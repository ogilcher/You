//
//  AnyView.swift
//  You App
//
//  Created by Oliver Gilcher on 2/5/25.
//

import SwiftUI

extension AnyView {
    static func fromString(for page: String) -> AnyView {
        switch (page) {
        case "FinanceLanding" : return AnyView(FinanceLanding())
        case "HealthLanding" : return AnyView(HealthLanding())
        case "HomeScreen" : return AnyView(HomeScreen())
        //case "Education" : return AnyView()
        default: return AnyView(HomeScreen())
        }
    }
}
