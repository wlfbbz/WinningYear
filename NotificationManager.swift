//
//  NotificationManager.swift
//  WinningYear
//
//  Created by Barbara on 13/02/2024.
//

import SwiftUI
import UserNotifications

class NotificationManager: ObservableObject {

    init() {
        requestAuthorization()
    }

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
    }

    func scheduleNotifications() {
        scheduleNotification(atHour: 20, minute: 41, title: "Time to reflect", message: "Tell us how your day went today") // 8:41 PM
        scheduleNotification(atHour: 15, minute: 0, title: "Winning Year", message: "You've got this, keep going!") // 3:00 PM
    }

    private func scheduleNotification(atHour hour: Int, minute: Int, title: String, message: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "dailyNotification_\(hour)_\(minute)", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully for \(hour):\(minute)")
            }
        }
    }
}
