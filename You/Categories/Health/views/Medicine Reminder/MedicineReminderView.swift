//
//  MedicineReminderView.swift
//  You
//
//  Created by Oliver Gilcher on 4/24/25.
//

import SwiftUI

struct MedicineReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = MedicineReminderViewModel()
    
    var body: some View {
        VStack {
            // Date selector
//            MedicineReminderDateSelector(selectedDate: $selectedDate)
            ScrollView {
                VStack {
                    ForEach(viewModel.medicineReminders, id: \.name) { medicine in
                        MedicineReminderSection(medicine: medicine)
                    }
                }
            }
            
            // List of medicines
            NavigationLink(
                destination: AddMedicineView().navigationBarBackButtonHidden(true),
                label: {
                    HStack {
                        Text("Add reminder")
                        Text("+")
                    }
                }
            )
        }
        .onAppear {
            viewModel.loadReminders()
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
                Text("Medicine Reminders")
            }
        }
    }
}

struct MedicineReminderDateSelector: View {
    //@Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            Text("4")
            Text("Tue")
            Text("April")
        }
    }
}

struct MedicineReminderSection: View {
    var medicine: Medicine
    
    var body: some View {
        VStack {
            Text("Dosages: \(medicine.dosage)")
            Text("Name: \(medicine.name)")
            Text("Take time: \(medicine.takeTime.formatted(date: .omitted, time: .shortened))")
        }
    }
}

#Preview {
    NavigationStack {
        MedicineReminderView()
    }
}
