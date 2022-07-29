//
//  EditTaskView.swift
//  NanoChallenge2
//
//  Created by Minawati on 27/07/22.
//

import SwiftUI

struct EditTaskView: View {
    @Binding var showEditTaskModal: Bool
    @Binding var task: Tasks
    
    @EnvironmentObject private var taskListViewModel: TaskListViewModel
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Input the task title", text: $task.title.toUnwrapped(defaultValue: "Test"))
                } header: {
                    Text("Task Title")
                        .offset(x: -20)
                }
                
                Section {
                    DatePicker(selection: $task.reminderTime.toUnwrapped(defaultValue: Date()), label: {Text("Date")})
                            .datePickerStyle(GraphicalDatePickerStyle())
                } header: {
                    Text("Reminder")
                        .offset(x: -20)
                }
            }
            .navigationBarTitle(Text("Edit Task"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.showEditTaskModal.toggle()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("DarkBlue"))
                },
            trailing:
                Button("Edit") {
                taskListViewModel.editTask(task: task)
                self.showEditTaskModal.toggle()
            }
            .foregroundColor(Color("DarkBlue")))
        }
        .onAppear {
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
            UINavigationBar.appearance().tintColor = UIColor(Color("DarkBlue"))
        }
    }
}

//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewContext = PersistenceController.preview.container.viewContext
//        let newTask = Tasks(context: viewContext)
//        newTask.title = "Search the resources"
//        newTask.reminderTime = Date()
//        newTask.isAchieved = false
//        newTask.timestamp = Date()
//        
//        return EditTaskView(showEditTaskModal: .constant(true), task: .constant(Tasks()))
//    }
//}
