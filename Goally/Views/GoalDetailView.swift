//
//  GoalDetailView.swift
//  NanoChallenge2
//
//  Created by Minawati on 22/07/22.
//

import SwiftUI

struct GoalDetailView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State var showAddGoalModal = false
    @State var showAddTaskModal = false
    @State var showEditTaskModal = false
    @State var showDeleteAlert = false
    
    @StateObject var goal: Goals
    @State var selectedTask: Tasks
    @State var deleteSelectedTask: Tasks
    
    @StateObject private var taskListViewModel = TaskListViewModel()
    @StateObject private var goalListViewModel = GoalListViewModel()
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    VStack {
                        HStack {
                            VStack (alignment: .leading) {
                                Text(goal.unwrappedTitle + " " + goal.unwrappedEmoji)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold))
                                    .padding(.bottom, 5)
                                
                                Text(goal.unwrappedDesc)
                                    .foregroundColor(.white)
                                    .lineSpacing(5)
                                    .font(.system(size: 14))
                            }
                            .frame(width: UIScreen.screenWidth*60/100, alignment: .leading)
                            .offset(x: 23, y: -15)

                            ZStack {
                                CircularProgressBarView(progress: goal.progress)
                                    .frame(width: 80, height: 80)
                                    .padding(.bottom, 20)
                                
                                Text("\(goal.progress)%")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .bold))
                                    .offset(y: -10)
                            }
                            .frame(width: UIScreen.screenWidth*40/100, alignment: .center)

                        }
                        .padding(.top, 15)
                        .padding(.bottom, 3)
                    }
                    .frame(width: UIScreen.screenWidth, height: 140)
                    .background(Color("DarkBlue"))
                    
                    Spacer()
                    
                    if (goal.tasksArray.count == 0) {
                        VStack {
                            Image("No-Tasks")
                                .resizable()
                                .scaledToFit()
        
                            Text("You've no tasks")
                                .font(.system(size: 18, weight: .bold))
                                .padding(.bottom, 3)
                                .frame(width: 390, alignment: .center)
        
                            Text("Add new task and start progressing")
                                .font(.system(size: 12))
                                .padding(.bottom, 10)
                                .frame(width: 390, alignment: .center)
                            
                            Button(action: {
                                self.showAddTaskModal.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus")
                                    
                                    Text("Add Task")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 344, height: 48)
                                .foregroundColor(.white)
                                .background(Color("DarkBlue"))
                                .cornerRadius(8)
                            }
                        }
                        
                    } else {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Your Tasks")
                                    .font(.system(size: 18, weight: .bold))
                                    .padding(.vertical, 15)
                                    .padding(.leading, 19)
                                
                                Spacer()
                                
                                Button(action: {
                                    self.showAddTaskModal.toggle()
                                }) {
                                    Label("Add", systemImage: "plus")
                                        .foregroundColor(Color("DarkBlue"))
                                        .offset(x: -17)
                                }
                            }
                            
                            List {
                                ForEach(Array(goal.tasksArray.enumerated()), id: \.offset) { index, task in
                                    VStack {
                                        HStack {
                                            Image(systemName: task.isAchieved ? "checkmark.square.fill" : "square")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(task.isAchieved ? Color("DarkBlue") : Color("DarkGray"))
                                                .onTapGesture {
                                                    task.isAchieved.toggle()
                                                    taskListViewModel.updateTask()
                                                    goalListViewModel.calculateProgress(goal: goal)
                                                    
                                                    if taskListViewModel.getTotalAchievedTask(goal: goal) == goal.tasksArray.count {
                                                        withAnimation {
                                                            self.presentation.wrappedValue.dismiss()
                                                            goalListViewModel.deleteGoal(goal: goal)
                                                        }
                                                    }
                                                }
                                            
                                            VStack (alignment: .leading) {
                                                Text(task.unwrappedTitle)
                                                    .font(.system(size: 14))
                                                    .padding(.bottom, 4)
                                                
                                                Text(task.unwrappedReminderTime, formatter: itemFormatter)
                                                    .foregroundColor(Color("DarkGray"))
                                                    .font(.system(size: 12))
                                                    .padding(.bottom, 4)
                                            }
                                            .padding(.leading)
                                            .padding(.vertical, 10)
                                            
                                            Spacer()
                                        }
                                    }
                                    .swipeActions(allowsFullSwipe: false) {
                                        Button("Delete", role: .destructive) {
                                            self.deleteSelectedTask = task
                                            self.showDeleteAlert.toggle()
                                        }

                                        Button("Edit") {
                                            self.selectedTask = task
                                            self.showEditTaskModal.toggle()
                                        }
                                        .tint(Color("DarkBlue"))
                                    }
                                }
                            }
                            .listStyle(.plain)
                        }
                    }

                    Spacer()
                }
                .navigationBarHidden(true)
            }
            .sheet(isPresented: $showAddTaskModal) {
                AddTaskView(showAddTaskModal: self.$showAddTaskModal, goals: goal).environmentObject(taskListViewModel)
            }
            .sheet(isPresented: $showEditTaskModal) {
                EditTaskView(showEditTaskModal: self.$showEditTaskModal, task: self.$selectedTask).environmentObject(taskListViewModel)
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Delete the task?"),
                    message: Text("Once you delete, your task will be deleted"),
                    primaryButton: .cancel (
                        Text("Cancel"),
                        action: {
                            self.showDeleteAlert.toggle()
                        }
                    ),
                    secondaryButton: .destructive (
                        Text("Delete"),
                        action: {
                            taskListViewModel.deleteTask(task: deleteSelectedTask)
                        }
                    )
                )
            }
        }
    }
}

struct GoalDetail_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newGoal = Goals(context: viewContext)
        newGoal.emoji = "😱"
        newGoal.title = "Learn UI/UX Design"
        newGoal.progress = 0
        newGoal.desc = "Mampu memahami dan sdasdasda adasdasda"
        newGoal.isAchieved = false
        newGoal.timestamp = Date()

        let newTask = Tasks(context: viewContext)
        newTask.title = "Search the resources"
        newTask.reminderTime = Date()
        newTask.isAchieved = false
        newTask.timestamp = Date()

        newGoal.addToTasks(newTask)

        return GoalDetailView(goal: newGoal, selectedTask: Tasks(), deleteSelectedTask: Tasks())
            .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
