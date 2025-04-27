//
//  AddMedicineViewModel.swift
//  You
//
//  Created by Oliver Gilcher on 4/24/25.
//

import Foundation
import FirebaseFirestore

@MainActor
final class AddMedicineViewModel: ObservableObject {
    @Published private(set) var user: DBHealthUser? = nil
    
    @Published var medicineName = ""
    @Published var medicineType = ""
    @Published var medicineDosage = 1
    @Published var medicineTakeTime = Date.now
    @Published var medicineStartDay = Date.now
    @Published var medicineDuration = 1
    @Published var medicineAlarm = true
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await MedicineManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func addMedicineReminder() {
        guard let user else { return }
        
        let reminder = Medicine(
            id: UUID().uuidString,
            name: medicineName,
            type: medicineType,
            dosage: medicineDosage,
            takeTime: medicineTakeTime,
            startDay: medicineStartDay,
            duration: medicineDuration,
            alarm: medicineAlarm
        )
        
        Task {
            try await MedicineManager.shared.addMedicineReminder(userId: user.userId, reminder: reminder)
            self.user = try await MedicineManager.shared.getUser(userId: user.userId)
        }
    }
}
