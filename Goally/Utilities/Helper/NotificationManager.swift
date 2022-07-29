//
//  NotificationManager.swift
//  NanoChallenge2
//
//  Created by Minawati on 27/07/22.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuth() {
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: option) { success, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification(task: Tasks) {
        let content = UNMutableNotificationContent()
        content.title = "Goally"
        content.subtitle = task.unwrappedTitle
        content.sound = .default
        content.badge = 1
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: task.unwrappedReminderTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: task.unwrappedTaskId.uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotification(taskId: UUID) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [taskId.uuidString])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [taskId.uuidString])
    }
}
