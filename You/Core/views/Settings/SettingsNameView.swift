//
//  SettingsNameView.swift
//  You
//
//  Created by Oliver Gilcher on 4/15/25.
//

import SwiftUI

@MainActor
final class SettingsNameViewModel : ObservableObject {
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func changefName(_ fName: String) async throws {
        
    }
}

struct SettingsNameView: View {
    @StateObject private var viewModel = SettingsNameViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("First name: \(viewModel.user?.fName ?? "None")")
            Text("Last name: \(viewModel.user?.fName ?? "None")")
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button(
                    action: {dismiss()},
                    label: {Image(systemName: "chevron.left")}
                )
                .foregroundStyle(.white)
            }
            ToolbarItemGroup(placement: .principal) {
                Text("Change your Name")
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .foregroundStyle(.white)
        .font(.system(size: 20))
        .frame(
            maxWidth: .infinity, maxHeight: .infinity
        )
        .ignoresSafeArea()
        .padding(.horizontal)
        .background(LinearGradient(colors: [.color1, .color2], startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    NavigationStack {
        SettingsNameView()
    }
}
