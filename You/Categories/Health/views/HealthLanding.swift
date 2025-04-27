//
//  HealthLanding.swift
//  You
//
//  Created by Oliver Gilcher on 4/23/25.
//

import SwiftUI

struct HealthLanding: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            NavigationLink(
                destination: MedicineReminderView().navigationBarBackButtonHidden(true),
                label: {
                    Text("Medicine Reminders")
                }
            )
            .frame(width: 350)
            .overlay {
                RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 2)
            }
        }
        .font(.system(size: 24, weight: .semibold))
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.red.gradient)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button(
                    action: {dismiss()},
                    label: {Image(systemName: "chevron.left")}
                )
                .foregroundStyle(.white)
            }
            ToolbarItemGroup(placement: .principal) {
                Text("Health")
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthLanding()
    }
}
