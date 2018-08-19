//
//  SolarLamp.swift
//  ARPlantEngine
//
//  Created by Tom on 15/08/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

struct SolarLamp: Upgrades {
    
    var solarLevel: Int
    var time: Int
    var quantity: Int
    var name: String
    var price: Int
    var currency: CurrencyType
    
    init() {
        self.solarLevel = 1
        self.time = 2
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
