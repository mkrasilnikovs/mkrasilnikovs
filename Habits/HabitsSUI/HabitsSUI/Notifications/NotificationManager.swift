//
//  NotificationManager.swift
//  HabitsSUI
//
//  Created by iosdev on 10/11/2021.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject{
    @Published private (set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    static let notificationManager = NotificationManager()
    private let delegate = NotificationHandler()
    
    func reloadAuthorizationStatus(){
        UNUserNotificationCenter.current().getNotificationSettings{ settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
        UNUserNotificationCenter.current().delegate = delegate
    }
    
    func requestAuthorisation(){
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: option) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized: .denied
            }
        }
    }
    func reloadLocalNotifications(){
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
    func removeSingleNotification(id: String){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])
    }
    
    func scheduleNotificanion(name: String ,time: Int ,completed: Bool, id: String)->Void{
        if completed == true{
            let content = UNMutableNotificationContent()
            content.title = "Habit"
            content.body = "Next Repeat in \(time) minutes"
            content.subtitle = name
            content.sound = .default
            content.badge = 1
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(time) * 60.0 , repeats: completed)
            let requests = UNNotificationRequest(identifier: id,
                                                 content: content,
                                                 trigger: trigger)
            UNUserNotificationCenter.current().add(requests, withCompletionHandler: nil)
        }
    }
    
    func cancelNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
