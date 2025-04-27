//
//  MedicineReminderViewModel.swift
//  You
//
//  Created by Oliver Gilcher on 4/24/25.
//

import Foundation

@MainActor
final class MedicineReminderViewModel : ObservableObject {
    @Published var medicineReminders: [Medicine] = []
    
    func loadReminders() {
        Task {
            do {
                let userId = try AuthenticationManager.shared.getAuthenticatedUser().uid
                self.medicineReminders = try await MedicineManager.shared.getMedicineReminders(userId: userId)
            } catch {
                print("Failed to load medicine reminders: \(error)")
            }
        }
    }
}
