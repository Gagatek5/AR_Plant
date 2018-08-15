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
    
    func use() //-> Date
    
    
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
