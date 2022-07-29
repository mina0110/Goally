//
//  EditGoalView.swift
//  NanoChallenge2
//
//  Created by Minawati on 27/07/22.
//

import SwiftUI

struct EditGoalView: View {
    @Binding var showEditGoalModal: Bool
    
    @State var emoji: String = ""
    @State var title: String = ""
    @State var description: String = ""
    
    @Binding var goals: Goals
    @EnvironmentObject private var goalListViewModel: GoalListViewModel
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    EmojiTextField(text: $goals.emoji.toUnwrapped(defaultValue: ""), placeholder: "Input emoji")
                } header: {
                    Text("Emoji")
                        .offset(x: -20)
                }
                
                Section {
                    TextField("Input the goal title", text: $goals.title.toUnwrapped(defaultValue: ""))
                        .lineLimit(1)
                } header: {
                    Text("Goal Title")
                        .offset(x: -20)
                }
                
                Section {
                    TextField("Input the goal description", text: $goals.desc.toUnwrapped(defaultValue: ""))
                        .lineLimit(2)
                } header: {
                    Text("Goal Description")
                        .offset(x: -20)
                }
            }
            .navigationBarTitle(Text("Edit Goal"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.showEditGoalModal.toggle()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("DarkBlue"))
                },
            trailing:
                Button("Edit") {
                    goalListViewModel.updateGoal()
                    self.showEditGoalModal.toggle()
            }
            .foregroundColor(Color("DarkBlue")))
        }
    }
}

struct EditGoalView_Previews: PreviewProvider {
    static var previews: some View {
        EditGoalView(showEditGoalModal: .constant(true), goals: .constant(Goals()))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
