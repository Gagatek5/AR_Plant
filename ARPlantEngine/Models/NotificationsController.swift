//
//  NotificationsController.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 08.08.2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class NotificationsController {
    
    func reminderNotification() {
        let title = "AR Plant - przypominajka!"
        let body = "Odwiedz swoja roslinke! Nie zapomnij sie nia opiekowac! I pamietaj: BLYSKAWICA UDERZA DWA RAZY!"
        let isRepeat = true
        var date = DateComponents()
        // wtorek
        date.weekday = 3
        date.hour = 18
        date.minute = 8
        UNService.shared.dateRequest(with: date, repeats: isRepeat, title: title, body: body)
    }
    
    func statusHasBeenChangedNotification() {
        let title = "AR Plant - time interval!"
        let body = "Twoja roslinka potrzebuje opieki! Zajrzyj do niej, inaczej uschnie!"
        let timeToStatusChange = howMuchTimeToStatusChange()
        UNService.shared.timerRequest(with: timeToStatusChange, title: title, body: body)
        
    }
    
    func howMuchTimeToStatusChange() -> TimeInterval {
        // do obliczenia czasu za jaki ma pojawic sie notyfikacja
        return 0
    }
    
    func pestsHasAppearedNotification() {
        let title = "AR Plant - szkodniki atakuja!"
        let body = "Twoja roslinke zaatakowaly szkodniki! Pomoz jej szybko!"
        var pests = false
        
        if(pests) {
            UNService.shared.timerRequest(with: 1, title: title, body: body)
        }
    }
    
    func bonusItemsHasEndedNotification() {
        let title = "AR Plant - koniec itemu!"
        let body = "Twoj item sie skonczyl!"
        
    }
    
}
