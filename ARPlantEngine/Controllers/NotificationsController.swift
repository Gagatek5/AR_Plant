//
//  NotificationsController.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 08.08.2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

open class NotificationsController {
    
    open func reminderNotification() {
        let isRepeat = true
        var date = DateComponents()
        // wtorek
        date.weekday = 3
        date.hour = 18
        date.minute = 0
        UNService.shared.dateRequest(with: date, repeats: isRepeat)
    }
    
}
