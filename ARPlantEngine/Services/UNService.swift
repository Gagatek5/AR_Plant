//
//  UNService.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 17/07/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation
import UserNotifications

class UNService: NSObject {
    
    private override init() {}
    static let shared = UNService()
    let unCenter =  UNUserNotificationCenter.current()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "no UN authorization error")
            guard granted else {
                 print("USER DENIED ACCESS")
                 return
            }
            self.configure()
        }
    }
    
    func configure() {
         unCenter.delegate = self
    }
    
    func timerRequest(with interval: TimeInterval, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = "AR Plant - time interval!"
        content.body = "Twoja roslinka potrzebuje opieki! Zajrzyj do niej, inaczej uschnie!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.timer", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
    
    func dateRequest(with date: DateComponents, repeats: Bool, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.calendar", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
}

extension UNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response")
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}
