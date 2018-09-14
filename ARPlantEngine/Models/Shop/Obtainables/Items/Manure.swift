//
//  Manure.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

struct Manure: Upgrades {
    var manureLevel: Int
    var time: Int
    var quantity: Int
    var name: String
    var price: Int
    var currency: CurrencyType
    
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
    
}
