//
//  ContentView.swift
//  NanoChallenge2
//
//  Created by Minawati on 21/07/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
            TabView {
                GoalView(selectedGoal: Goals())
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
            
                AchievementView()
                    .tabItem {
                        Image(systemName: "rosette")
                        Text("Achievement")
                    }
            }
            .accentColor(Color("DarkBlue"))
            .onAppear {
                NotificationManager.instance.requestAuth()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
