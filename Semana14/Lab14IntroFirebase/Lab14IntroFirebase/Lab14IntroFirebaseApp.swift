//
//  Lab14IntroFirebaseApp.swift
//  Lab14IntroFirebase
//

import SwiftUI
import FirebaseCore

@main
struct Lab14IntroFirebaseApp: App {

    // Configure Firebase when app starts
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)   // la app usa un tema oscuro
        }
    }
}
