//
//  SettingsView.swift
//  You
//
//  Created by Oliver Gilcher on 1/26/25.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView : View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SettingsViewModel()
    
    var body : some View {
        ScrollView {
            VStack (spacing: 20) {
                Text("Account")
                    .font(.system(size: 18, weight: .semibold))
                    
                VStack (spacing: 10) {
                    SettingButton(title: " Name", image: "person.fill", destination: AnyView(SettingsNameView()))
                    SettingButton(title: "Email", image: "envelope.fill", destination: AnyView(self))
                    SettingButton(title: "  Password", image: "key.fill", destination: AnyView(self))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.white.quinary)
                .clipShape(.rect(cornerRadius: 10))
                
                Text("Personalization")
                    .font(.system(size: 18, weight: .semibold))
                
                VStack (spacing: 10) {
                    SettingButton(title: "Notifications", image: "bell.fill", destination: AnyView(self))
                    SettingButton(title: "Wallpaper", image: "paintpalette.fill", destination: AnyView(self))
                    SettingButton(title: "Accessibility", image: "accessibility.fill", destination: AnyView(self))
                    SettingButton(title: "Display", image: "moon.fill", destination: AnyView(self))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.white.quinary)
                .clipShape(.rect(cornerRadius: 10))
                
                Text("Support & About")
                    .font(.system(size: 18, weight: .semibold))
                VStack (spacing: 10) {
                    SettingButton(title: "Report a problem", image: "flag.fill", destination: AnyView(self))
                    SettingButton(title: "Support", image: "bubble.left.and.exclamationmark.bubble.right.fill", destination: AnyView(self))
                    SettingButton(title: "Terms and Policies", image: "info.circle.fill", destination: AnyView(self))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.white.quinary)
                .clipShape(.rect(cornerRadius: 10))
                
                Text("Login")
                    .font(.system(size: 18, weight: .semibold))
                
                VStack (spacing: 10) {
                    Button(
                        action: {
                            Task {
                                do {
                                    try viewModel.logOut()
                                } catch {
                                    print(error)
                                }
                            }
                        }, label: {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                                    .foregroundStyle(.gray)
                                Text("Log out")
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal)
                            .font(.system(size: 16, weight: .semibold))
                            
                        }
                    )
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.white.quinary)
                .clipShape(.rect(cornerRadius: 10))
            }
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
                Text("Settings")
            }
        }
        .foregroundStyle(.white)
        .font(.system(size: 20))
        .frame(
            maxWidth: .infinity, maxHeight: .infinity
        )
        .ignoresSafeArea()
        .padding()
        .background(LinearGradient(colors: [.color1, .color2], startPoint: .top, endPoint: .bottom))
    }
    
}

struct SettingButton : View {
    var title : String
    var image : String
    var destination: AnyView

    
    var body : some View {
        NavigationLink(
            destination: destination.navigationBarBackButtonHidden(),
            label: {
                HStack (spacing: 10) {
                    Image(systemName: image)
                        .foregroundStyle(.gray)
                    Text(title)
                        .foregroundStyle(.white)
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
                .font(.system(size: 16, weight: .semibold))
            }
        )
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
