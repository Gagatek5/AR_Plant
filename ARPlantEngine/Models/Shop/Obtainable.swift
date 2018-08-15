//
//  Obtainable.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

// klasa nadrzedna dla wszystkich rzeczy mozliwych do kupienia
class Obtainable {
    
    let name: String
    let price: Int
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}
