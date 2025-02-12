//
//  PetBMICalculator.swift
//  You
//
//  Created by Oliver Gilcher on 2/6/25.
//

import SwiftUI

struct PetBMICalculator: View {
    @AppStorage("backgroundColor") private var backgroundColor: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.fromString(from: backgroundColor))
        }
    }
}

#Preview {
    PetBMICalculator()
}
