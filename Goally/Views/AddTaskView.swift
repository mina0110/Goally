//
//  AddTaskView.swift
//  NanoChallenge2
//
//  Created by Minawati on 22/07/22.
//

import SwiftUI

struct AddTaskView: View {
    @Binding var showAddTaskModal: Bool
    
    @State var title: String = ""
    @State var selectedDate = Date()
    @StateObject var goals: Goals
    
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Input the task title", text: $title)
                } header: {
                    Text("Task Title")
                        .offset(x: -20)
                }
                
                Section {
                    DatePicker(selection: $selectedDate, label: { Text("Date") })
                        .datePickerStyle(GraphicalDatePickerStyle())
                } header: {
                    Text("Reminder")
                        .offset(x: -20)
                }
            }
            .navigationBarTitle(Text("Add Task"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.showAddTaskModal.toggle()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("DarkBlue"))
                },
            trailing:
                Button("Add") {
                taskListViewModel.addTask(goal: goals, title: title, reminderTime: selectedDate)
                self.showAddTaskModal.toggle()
            }
            .foregroundColor(Color("DarkBlue")))
        }
        .onAppear {
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
            UINavigationBar.appearance().tintColor = UIColor(Color("DarkBlue"))
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newGoal = Goals(context: viewContext)
        newGoal.emoji = "😱"
        newGoal.title = "Learn UI/UX Design"
        newGoal.progress = 0
        newGoal.desc = "Mampu memahami dan sdasdasda adasdasda"
        newGoal.isAchieved = false
        newGoal.timestamp = Date()
        
        return AddTaskView(showAddTaskModal: .constant(true), goals: newGoal)
    }
}
