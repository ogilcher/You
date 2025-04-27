//
//  MedicineManager.swift
//  You
//
//  Created by Oliver Gilcher on 4/25/25.
//

import Foundation
import FirebaseFirestore

struct DBHealthUser: Codable {
    let userId: String
    let dateCreated: Timestamp
    let medicineReminders: [Medicine]?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.dateCreated = Timestamp()
        self.medicineReminders = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case dateCreated = "date_created"
        case medicineReminders = "medicine_reminders"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.dateCreated = try container.decode(Timestamp.self, forKey: .dateCreated)
        self.medicineReminders = try container.decodeIfPresent([Medicine].self, forKey: .medicineReminders)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.medicineReminders, forKey: .medicineReminders)
    }
}

final class MedicineManager {
    static let shared = MedicineManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func medicineDocument(userId: String) -> DocumentReference {
        userCollection.document(userId).collection("apps").document("medicine")
    }
    
    func createNewUser() async throws {
        let user = DBHealthUser(auth: try AuthenticationManager.shared.getAuthenticatedUser())
        try medicineDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBHealthUser {
        try await medicineDocument(userId: userId).getDocument(as: DBHealthUser.self)
    }
    
    func getMedicineReminders(userId: String) async throws -> [Medicine] {
        let snapshot = try await medicineDocument(userId: userId).getDocument()
        
        guard let data = snapshot.data(),
              let rawArray = data[DBHealthUser.CodingKeys.medicineReminders.rawValue] as? [[String:Any]] else {
            return []
        }

        let medicines: [Medicine] = try rawArray.map { dict in
            try Firestore.Decoder().decode(Medicine.self, from: dict)
        }

        return medicines
    }
    
    func addMedicineReminder(userId: String, reminder: Medicine) async throws {
        let data: [String: Any] = [
            Medicine.CodingKeys.id.rawValue: reminder.id,
            Medicine.CodingKeys.name.rawValue: reminder.name,
            Medicine.CodingKeys.type.rawValue: reminder.type,
            Medicine.CodingKeys.dosage.rawValue: reminder.dosage,
            Medicine.CodingKeys.takeTime.rawValue: Timestamp(date: reminder.takeTime),
            Medicine.CodingKeys.startDay.rawValue: Timestamp(date: reminder.startDay),
            Medicine.CodingKeys.duration.rawValue: reminder.duration,
            Medicine.CodingKeys.alarm.rawValue: reminder.alarm
        ]
        
        let dict: [String: Any] = [
            DBHealthUser.CodingKeys.medicineReminders.rawValue: FieldValue.arrayUnion([data])
        ]
        
        try await medicineDocument(userId: userId).updateData(dict)
    }
    
    func editMedicineReminder(userId: String, updatedReminder: Medicine) async throws {
        let currentReminders = try await getMedicineReminders(userId: userId)
        
        var newReminders = currentReminders.map { reminder -> Medicine in
            if reminder.id == updatedReminder.id {
                return updatedReminder
            } else {
                return reminder
            }
        }
        
        let encodedReminders = try newReminders.map { try Firestore.Encoder().encode($0) }
        let dict: [String: Any] = [
            DBHealthUser.CodingKeys.medicineReminders.rawValue: encodedReminders
        ]
        
        try await medicineDocument(userId: userId).updateData(dict)
    }
    
    func removeMedicineReminder(userId: String, reminder: Medicine) async throws {
        let data: [String: Any] = [
            Medicine.CodingKeys.id.rawValue: reminder.id,
            Medicine.CodingKeys.name.rawValue: reminder.name,
            Medicine.CodingKeys.type.rawValue: reminder.type,
            Medicine.CodingKeys.dosage.rawValue: reminder.dosage,
            Medicine.CodingKeys.takeTime.rawValue: Timestamp(date: reminder.takeTime),
            Medicine.CodingKeys.startDay.rawValue: Timestamp(date: reminder.startDay),
            Medicine.CodingKeys.duration.rawValue: reminder.duration,
            Medicine.CodingKeys.alarm.rawValue: reminder.alarm
        ]
        
        let dict: [String: Any] = [
            DBHealthUser.CodingKeys.medicineReminders.rawValue: FieldValue.arrayRemove([data])
        ]
        
        try await medicineDocument(userId: userId).updateData(dict)
    }
}
