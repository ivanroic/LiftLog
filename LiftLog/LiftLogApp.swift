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
}

@main
struct LiftLogApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RecordTextView().environmentObject(SwiftUISpeech())
            //WorkoutListView()
        }
        .onChange(of: scenePhase) { phase in
                    INPreferences.requestSiriAuthorization({status in
                        // Handle errors here
                    })
                }
    }
}
