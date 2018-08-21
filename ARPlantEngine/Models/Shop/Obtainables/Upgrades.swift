//
//  Upgrades.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

protocol Upgrades: Obtainable {
    
    var time: Int { get set }
    var quantity: Int { get set }
    
    func use(upgradeItem: Upgrade) //-> Date
    
    
//    var name: String
//    var price: Int
//    var currency: Currency
//
//    init(name: String, price: Int, currency: Currency) {
//        self.name = name
//        self.price = price
//        self.currency = currency
//    }
    
    // upgrade'y pozwalajace np na zwiekszona odpornosc na zaraze, albo x2 bonus do roznych zmiennych na iles tam czasu
}

enum Upgrade {
    case Manure
    case SolarLamp
    case InsectRepelent
}

extension Upgrades {
    func use(upgradeItem: Upgrade) {
        var uitemIndex: Int
        
        switch upgradeItem {
        case .Manure: uitemIndex = 0
        case .InsectRepelent: uitemIndex = 1
        case .SolarLamp: uitemIndex = 2
        }
        
        let p = Player.instance
        if !p.activeUpgradesList.keys.contains(upgradeItem) && p.upgradesList[uitemIndex]>=1{
            let time = self.time * 3600
            p.activeUpgradesList.updateValue(time, forKey: upgradeItem)
            print("warunek spelniony\nmanure: \(String(describing: p.activeUpgradesList[upgradeItem]))")
            p.upgradesList[uitemIndex] -= 1
            NotificationsController.bonusItemsHasEndedNotification(bonusItemTime: time)
        } else {
            print("NIE \(uitemIndex)!")
        }
    }
}
