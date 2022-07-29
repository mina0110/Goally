//
//  NanoChallenge2App.swift
//  NanoChallenge2
//
//  Created by Minawati on 21/07/22.
//

import SwiftUI

@main
struct NanoChallenge2App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
