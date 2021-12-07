//
//  PushNotificationsManager.swift
//  BaseApp
//
//  Created by Jason Jon E. Carreos on 12/7/21.
//  Copyright © 2021 BTCalls. All rights reserved.
//

import UIKit
import UserNotifications

private extension UNAuthorizationOptions {

    static let all: Self = [.alert, .sound, .badge]

}

private extension UNNotification {

    var userInfo: [AnyHashable: Any] {
        return request.content.userInfo
    }

}

private extension UNNotificationResponse {

    var userInfo: [AnyHashable: Any] {
        return notification.userInfo
    }

}

private struct Payload: Codable {

    // TODO: Define properties based on notification payload

}

class PushNotificationsManager: NSObject, CapabilityManager {

    static let shared = PushNotificationsManager()

    var isAuthorized: Bool = false

    func configure() {
        UNUserNotificationCenter.current().delegate = self

        clearBadgeCount()
    }

    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: .all) { [weak self] (granted, error) in
            self?.isAuthorized = error == nil && granted

            DispatchQueue.main.async {
                self?.presentRequireDialog(.notifications)
            }
        }

        UIApplication.shared.registerForRemoteNotifications()
    }

    func clearBadgeCount() {
        DispatchQueue.main.async {
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()

            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }

    func handleNotification(_ notification: UNNotification) {
        // TODO: Parse notification; Perform action if needed
    }

    func register(token: Data) {
        // TODO: Submit to API
    }

}

extension PushNotificationsManager: UNUserNotificationCenterDelegate {

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        handleNotification(response.notification)
    }

}
