//
//  EditMedicineViewModel.swift
//  You
//
//  Created by Oliver Gilcher on 4/26/25.
//

import Foundation
import FirebaseFirestore

@MainActor
final class EditMedicineViewModel: ObservableObject {
    @Published private(set) var user: DBHealthUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await MedicineManager.shared.getUser(userId: authDataResult.uid)
    }
    
}
