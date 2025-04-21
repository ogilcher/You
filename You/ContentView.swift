//
//  ContentView.swift
//  You
//
//  Created by Oliver Gilcher on 1/23/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSignInView: Bool = false
    @AppStorage("isWelcomeOver") var isWelcomeOver = true
    
    var body: some View {
        VStack {
            if isWelcomeOver {
                HomeScreen()
                    .onAppear{
                        let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                        self.showSignInView = authUser == nil
                    }
                    .fullScreenCover(isPresented: $showSignInView) {
                        NavigationStack {
                            AuthenticationView(showSignInView: $showSignInView)
                        }
                    }
            } else {
                WelcomeView1()
            }
        }
        .onAppear{
            isWelcomeOver = isWelcomeOver
        }
    }
}

#Preview {
    ContentView()
}
