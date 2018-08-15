//
//  SolarLamp.swift
//  ARPlantEngine
//
//  Created by Tom on 15/08/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class SolarLamp: Upgrades {
    
    var solarLevel: Int
    var time: Int
    var quantity: Int
    var name: String
    var price: Int
    var currency: CurrencyType
    
    func use() {
//        var date = Date()
//        date = Calendar.current.date(byAdding: .hour,  value: self.time, to: Date())!
//        return date
        let p = Player.instance
        
        if !p.activeUpgradesList.keys.contains(.SolarLamp) && p.upgradesList[2]>=1{
            let time = self.time * 60 // * 3600
            p.activeUpgradesList.updateValue(time, forKey: .SolarLamp)
            print("warunek spelniony\nsolar: \(String(describing: p.activeUpgradesList[.SolarLamp]))")
            p.upgradesList[2] -= 1
        } else {
            print("NIE S!")
        }
    }
    
    init() {
        self.solarLevel = 1
        self.time = 1
        self.quantity = 1
        self.name = "Cheap Lamp"
        self.price = 10
        self.currency = .PlantCoin
    }
    
    init(solarLevel: Int, time: Int, quantity: Int, name: String, price: Int, currency: CurrencyType) {
        self.solarLevel = solarLevel
        self.time = time
        self.quantity = quantity
        self.name = name
        self.price = price
        self.currency = currency
    }
    
}
