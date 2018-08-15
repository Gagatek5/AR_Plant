//
//  Manure.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class Manure: Upgrades {
    var manureLevel: Int
    var time: Int
    var quantity: Int
    var name: String
    var price: Int
    var currency: CurrencyType
    
    func use()  {
//        var date = Date()
//        date = Calendar.current.date(byAdding: .hour,  value: self.time, to: Date())!
//        return date
        let p = Player.instance
        
        if !p.activeUpgradesList.keys.contains(.Manure) && p.upgradesList[0]>=1{
            let time = self.time * 3600
            p.activeUpgradesList.updateValue(time, forKey: .Manure)
            print("warunek spelniony\nmanure: \(String(describing: p.activeUpgradesList[.Manure]))")
            p.upgradesList[0] -= 1
        } else {
            print("NIE M!")
        }
    }
    
    
    init() {
        self.manureLevel = 1
        self.time = 4
        self.quantity = 1
        self.name = "Normal Manure"
        self.price = 10
        self.currency = .PlantCoin
    }
    
    init(manureLevel: Int, time: Int, quantity: Int, name: String, price: Int, currency: CurrencyType) {
        self.manureLevel = manureLevel
        self.time = time
        self.quantity = quantity
        self.name = name
        self.price = price
        self.currency = currency
    }
    
    // dodaj do listy upgrade'ow zwiazanych z rosnieciem
    
}
