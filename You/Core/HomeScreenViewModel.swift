//
//  HomeScreenViewModel.swift
//  You
//
//  Created by Oliver Gilcher on 4/2/25.
//

import Foundation

final class HomeScreenViewModel : ObservableObject {
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}
