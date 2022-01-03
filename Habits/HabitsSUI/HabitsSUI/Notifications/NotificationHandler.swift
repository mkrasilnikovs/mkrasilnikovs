//
//  NotificationHandler.swift
//  HabitsSUI
//
//  Created by iosdev on 30/11/2021.
//

import Foundation
import UserNotifications
import SwiftUI

class NotificationHandler: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }
}
