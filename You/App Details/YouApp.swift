//
//  YouApp.swift
//  You
//
//  Created by Oliver Gilcher on 1/23/25.
//
import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

@main
struct YouApp: App {
    // Register AppDelegate for Firebase & FatSecret setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(
            for: [
                AppCategory.self
            ]
        )
    }
}
