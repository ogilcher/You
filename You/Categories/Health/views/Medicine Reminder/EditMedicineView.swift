//
//  EditMedicineView.swift
//  You
//
//  Created by Oliver Gilcher on 4/26/25.
//

import SwiftUI

struct EditMedicineView: View {
    var medicine: Medicine
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = EditMedicineViewModel()
    
    var body: some View {
        VStack {
            
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.loadCurrentUser()
                } catch {
                    print("Failed to load user: \(error.localizedDescription)")
                }
            }
        }
        .padding()
        .font(.system(size: 20, weight: .semibold))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.voidBlack.gradient)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItemGroup(placement: .principal) {
                Text("Add new Medicine")
            }
        }
    }
    
}

#Preview {
    EditMedicineView(medicine: Medicine(id: "0", name: "Ibuprofen", type: "tablet", dosage: 1, takeTime: Date.now, startDay: Date.now, duration: 60, alarm: true))
}
