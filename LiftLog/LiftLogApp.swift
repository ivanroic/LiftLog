//
//  LiftLogApp.swift
//  LiftLog
//
//  Created by Ivan R on 2022-01-11.
//

import Firebase
import SwiftUI
import Intents

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

@main
struct LiftLogApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            WorkoutListView()
        }
        .onChange(of: scenePhase) { phase in
                    INPreferences.requestSiriAuthorization({status in
                        // Handle errors here
                    })
                }
    }
}
