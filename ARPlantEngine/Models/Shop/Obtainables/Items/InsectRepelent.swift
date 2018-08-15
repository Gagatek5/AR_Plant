//
//  InsectRepelent.swift
//  ARPlantEngine
//
//  Created by Tom on 15/08/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class InsectRepelent: Upgrades {
    
    var solarLevel: Int
    var time: Int
    var quantity: Int
    var name: String
    var price: Int
    var currency: CurrencyType
    
    func use() {
//        var date = Date()
//        date = Calendar.current.date(byAdding: .hour,  value: self.time, to: Date())!
//        print("DATA: \(date)")
//        return date
        let p = Player.instance
        
        if !p.activeUpgradesList.keys.contains(.InsectRepelent) && p.upgradesList[1]>=1{
            let time = self.time * 3600
            p.activeUpgradesList.updateValue(time, forKey: .InsectRepelent)
            print("warunek spelniony\nrepel: \(String(describing: p.activeUpgradesList[.InsectRepelent]))")
            p.upgradesList[1] -= 1
        } else {
            print("NIE R!")
        }
    }
    
    init() {
        self.solarLevel = 1
        self.time = 4
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
