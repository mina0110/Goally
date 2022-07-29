//
//  AchievementView.swift
//  NanoChallenge2
//
//  Created by Minawati on 22/07/22.
//

import SwiftUI

struct AchievementView: View {
    
    @State var selection = 1
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("DarkBlue"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("DarkBlue"))], for: .normal)
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                Picker(selection: $selection, label: Text("Achievement Picker")) {
                    Text("All").tag(1)
                    Text("Achieved").tag(2)
                }
                .pickerStyle(.segmented)
                .overlay(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .stroke(Color("DarkBlue"), lineWidth: 1)
                )
                .padding(.horizontal, 19)
                .padding(.top, 20)
                
                if selection == 1 {
                    List {
                        AchievementCellView(achievementTitle: "First Task", achievementDescription: "Earn this reward when you finish your first task")
                        AchievementCellView(achievementTitle: "5 Tasks", achievementDescription: "Complete 5 tasks to earn this reward")
                            .opacity(0.4)
                        AchievementCellView(achievementTitle: "15 Tasks", achievementDescription: "Complete 15 tasks to earn this reward")
                            .opacity(0.4)
                        AchievementCellView(achievementTitle: "20 Tasks", achievementDescription: "Complete 20 tasks to earn this reward")
                            .opacity(0.4)
                        AchievementCellView(achievementTitle: "First Goal", achievementDescription: "Earn this reward when you achieve your first goal")
                        AchievementCellView(achievementTitle: "3 Goal", achievementDescription: "Earn this reward when you achieve 3 goals")
                            .opacity(0.4)
                        AchievementCellView(achievementTitle: "5 Goals", achievementDescription: "Earn this reward when you achieve 5 goals")
                            .opacity(0.4)
                        AchievementCellView(achievementTitle: "10 Goals", achievementDescription: "Earn this reward when you achieve 10 goals")
                            .opacity(0.4)
                        AchievementCellView(achievementTitle: "15 Goals", achievementDescription: "Earn this reward when you achieve 15 goals")
                            .opacity(0.4)
                    }
                    .listStyle(.plain)
                    .padding(.top, 10)
                } else {
                    List {
                        AchievementCellView(achievementTitle: "First Task", achievementDescription: "Earn this reward when you finish your first task")
                        AchievementCellView(achievementTitle: "First Goal", achievementDescription: "Earn this reward when you achieve your first goal")
                    }
                    .listStyle(.plain)
                    .padding(.top, 10)
                }
                
                Spacer()
            }
            .navigationBarTitle(Text("Achievement"), displayMode: .inline)
        }
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView()
    }
}
