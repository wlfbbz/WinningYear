//
//  NotificationsSettingsView.swift
//  WinningYear
//
//  Created by Barbara on 23/03/2024.
//

import SwiftUI
import UserNotifications

struct NotificationsSettingsView: View {
    @ObservedObject private var notificationManager = NotificationManager()
    @State private var isReflectionNotificationEnabled: Bool = false
    @State private var isMotivationNotificationEnabled: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notifications")) {
                    Toggle(isOn: $isReflectionNotificationEnabled) {
                        Text("Time To Reflect Reminder")
                    }
                    .onChange(of: isReflectionNotificationEnabled) { newValue in
                        if newValue {
                            notificationManager.scheduleNotification(atHour: 20, minute: 41, title: "Time to reflect", message: "Tell us how your day went today")
                        } else {
                            notificationManager.removeNotification(identifier: "dailyNotification_20_41")
                        }
                    }
                    
                    Toggle(isOn: $isMotivationNotificationEnabled) {
                        Text("Daily Motivation Reminder")
                    }
                    .onChange(of: isMotivationNotificationEnabled) { newValue in
                        if newValue {
                            notificationManager.scheduleNotification(atHour: 15, minute: 0, title: "Winning Year", message: "You've got this, keep going!")
                        } else {
                            notificationManager.removeNotification(identifier: "dailyNotification_15_0")
                        }
                    }
                }
            }
            .navigationBarTitle("Settings")
            .font(.subheadline)
            .navigationBarItems(trailing:
                                    Button(action: cancelButtonPressed) {
                Image("crossnofill")
                    .resizable()
                    .frame(width: 20, height: 20)
            })
        }
        .onAppear {
            checkNotificationStatus()
        }
    }
    
    private func checkNotificationStatus() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            DispatchQueue.main.async {
                isReflectionNotificationEnabled = requests.contains { $0.identifier == "dailyNotification_20_41" }
                isMotivationNotificationEnabled = requests.contains { $0.identifier == "dailyNotification_15_0" }
            }
        }
    }
    func cancelButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
}
#Preview {
    NotificationsSettingsView()
}
