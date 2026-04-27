//
//  NotificationManager.swift
//  FluentEcho
//
//  Created by Fidel Fausta Cavell on 24/04/26.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    // Request notification permission from the user
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if success {
                print("Permission granted for notifications")
                completion(true)
            } else if let error = error {
                print("Error requesting permission: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func scheduleDailyNotification(hour: Int, minute: Int, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 300, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
        print("Notification cancelled")
    }
    
    // Check user's current weekly progression and schedule notification if needed
    func checkProgressAndNotify(weeklyGoal: Int, currentProgress: Int, hour: Int, minute: Int) {
        if currentProgress < weeklyGoal {
            scheduleDailyNotification(hour: hour, minute: minute, title: "Reminder", body: "You're behind your weekly goal! Let's back to continue progressing!")
        } else {
            cancelNotification()
        }
    }
    
    // Check the current notification authorization status
    func checkNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
