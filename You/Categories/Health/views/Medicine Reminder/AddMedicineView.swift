//
//  AddMedicineView.swift
//  You
//
//  Created by Oliver Gilcher on 4/24/25.
//

import SwiftUI

struct AddMedicineView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var medicineName: String = ""
    @StateObject private var viewModel = AddMedicineViewModel()
    
    var body: some View {
        VStack {
            // Medicine Name TextField
            TextField("Medicine name...", text: $viewModel.medicineName)
            Divider()
            // Medicine Type picker
            HStack {
                Button {
                    viewModel.medicineType = "Tablet"
                } label: {
                    Text("Tablet")
                }
                Button {
                    viewModel.medicineType = "Capsule"
                } label: {
                    Text("Capsule")
                }
                Button {
                    viewModel.medicineType = "Drops"
                } label: {
                    Text("Drops")
                }
                Button {
                    viewModel.medicineType = "Injection"
                } label: {
                    Text("Injection")
                }
            }
            // Reminder times
            HStack {
                Text("Reminder Times")
                Text("Once") // TODO: Drop down menu
            }
            // Dosage picker
            HStack {
                Text("Dosage (per day)")
                Spacer()
                Button {
                    viewModel.medicineDosage += 1
                } label: {
                    Text("+")
                }
                Text("\(viewModel.medicineDosage)")
                Button {
                    viewModel.medicineDosage -= 1
                } label: {
                    Text("-")
                }
            }
            // TODO: Time picker
            HStack {
                Button {
                    print("pressed time button!")
                } label: {
                    HStack {
                        Image(systemName: "clock.fill")
                        Text("\(viewModel.medicineTakeTime)")
                    }
                }
            }
            // TODO: Start date picker
            HStack {
                Text("Start")
                Spacer()
                Text("Today")
            }
            // Duration choice
            HStack {
                Text("Duration")
                Spacer()
                Text("1 Month") // TODO: Make dropdown choices for duration
            }
            HStack {
                Text("Alarm")
                Spacer()
                Button {
                    viewModel.medicineAlarm.toggle()
                } label: {
                    Text("\(viewModel.medicineAlarm)") // TODO: Make toggle for this
                }
            }
            
            Button {
                viewModel.addMedicineReminder()
            } label: {
                Text("Add schedule")
            }
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
    AddMedicineView()
}
