//
//  NotificationScheduler.swift
//  MedicationManager
//
//  Created by Tim Green on 7/28/21.
//

import UserNotifications

class NotificationScheduler {
    
    func scheduleNotification(for medication: Medication) {
        guard let timeOfDay = medication.timeOfDay,
              let identifier = medication.id?.uuidString else { return }
        
        clearNotifications(for: medication)
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "It's time to take your \(medication.name ?? StringConstants.medication)"
        content.sound = .default
        content.userInfo = [StringConstants.medicationID : identifier]
        content.categoryIdentifier = StringConstants.medicationReminderCategoryIdentifier
        
        let fireDateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeOfDay)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    func clearNotifications(for medication: Medication) {
        guard let identifier = medication.id?.uuidString else { return }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
} // End of class
