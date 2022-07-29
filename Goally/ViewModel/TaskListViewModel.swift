//
//  TaskListViewModel.swift
//  NanoChallenge2
//
//  Created by Minawati on 28/07/22.
//

import Foundation
import CoreData
import SwiftUI

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Tasks] = []
    
    func getAllTasks() {
        tasks =  CoreDataManager.shared.getAllTasks()
    }
    
    func addTask(goal: Goals, title: String, reminderTime: Date) {
        let newTask = Tasks(context: CoreDataManager.shared.viewContext)
        
        newTask.taskId = UUID()
        newTask.title = title
        newTask.reminderTime = reminderTime
        newTask.isAchieved = false
        newTask.timestamp = Date()
        
        goal.addToTasks(newTask)
        NotificationManager.instance.scheduleNotification(task: newTask)

        CoreDataManager.shared.saveContext()
        getAllTasks()
    }
    
    func updateTask() {
        CoreDataManager.shared.saveContext()
        getAllTasks()
    }
    
    // update title and reminder task
    func editTask(task: Tasks) {
        NotificationManager.instance.scheduleNotification(task: task)
        CoreDataManager.shared.saveContext()
        getAllTasks()
    }
    
    func deleteTask(task: Tasks) {
        NotificationManager.instance.removeNotification(taskId: task.unwrappedTaskId)
        
        CoreDataManager.shared.deleteTasks(task: task)
        getAllTasks()
    }
    
    func getTotalAchievedTask(goal: Goals) -> Int {
        var totalAchieved = 0
        
        for task in goal.tasksArray {
            if task.isAchieved {
                totalAchieved += 1
            }
        }
        
        return totalAchieved
    }
}
