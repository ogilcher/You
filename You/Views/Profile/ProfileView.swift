//
//  ProfileView.swift
//  You
//
//  Created by Oliver Gilcher on 2/7/25.
//

import SwiftUI

@MainActor
final class ProfileViewModel : ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func togglePremiumStatus() {
        guard let user else { return }
        let currentValue = user.isPremium ?? false
        Task {
            try await UserManager.shared.updateUserPremiumStatus(userId: user.userId, isPremium: !currentValue)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
}

struct ProfileView: View {
    @AppStorage("backgroundColor") var backgroundColor : String?
    @StateObject private var viewModel = ProfileViewModel()
    
    @State var showSignInView : Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                if let user = viewModel.user {
                    Text("UserId: \(user.userId)")
                    
                    Button {
                        viewModel.togglePremiumStatus()
                    } label: {
                        Text("user is premium: \((user.isPremium ?? false).description.capitalized)")
                    }
                }
            }
            .onAppear{
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                self.showSignInView = authUser == nil
            }
            .fullScreenCover(isPresented: $showSignInView) {
                NavigationStack {
                    AuthenticationView(showSignInView: $showSignInView)
                }
            }
            .task {
                try? await viewModel.loadCurrentUser()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.fromString(from: backgroundColor).gradient)
        }
    }
}

#Preview {
    ProfileView()
}
