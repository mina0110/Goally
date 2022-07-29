//
//  AddGoalView.swift
//  NanoChallenge2
//
//  Created by Minawati on 22/07/22.
//

import SwiftUI

struct AddGoalView: View {
    
    @Binding var showModal: Bool
    @State var emoji: String = ""
    @State var title: String = ""
    @State var description: String = ""
    @State var stateAction: String = ""
    
    @EnvironmentObject private var goalListViewModel: GoalListViewModel
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    EmojiTextField(text: $emoji, placeholder: "Input emoji")
                } header: {
                    Text("Emoji")
                        .offset(x: -20)
                }
                
                Section {
                    TextField("Input the goal title", text: $title)
                        .lineLimit(1)
                } header: {
                    Text("Goal Title")
                        .offset(x: -20)
                }
                
                Section {
                    TextField("Input the goal description", text: $description)
                        .lineLimit(2)
                } header: {
                    Text("Goal Description")
                        .offset(x: -20)
                }
            }
            .navigationBarTitle(Text("Add Goal"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.showModal.toggle()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("DarkBlue"))
                },
            trailing:
                Button("Add") {
                    goalListViewModel.addGoal(emoji: emoji, title: title, desc: description)
                    self.showModal.toggle()
            }
            .foregroundColor(Color("DarkBlue")))
        }
    }
}

struct AddGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddGoalView(showModal: .constant(true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
