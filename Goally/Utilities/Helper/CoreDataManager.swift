//
//  CoreDataManager.swift
//  NanoChallenge2
//
//  Created by Minawati on 27/07/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "NanoChallenge2CoreDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    // GOALS
    
    func getAllGoals() -> [Goals] {    
        let request = NSFetchRequest<Goals>(entityName: "Goals")
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func deleteGoals(goal: Goals) {
        viewContext.delete(goal)

        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // TASKS
    
    func getAllTasks() -> [Tasks] {
        let request = NSFetchRequest<Tasks>(entityName: "Tasks")
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func deleteTasks(task: Tasks) {
        viewContext.delete(task)

        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
