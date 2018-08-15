//
//  Player.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 14.08.2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class Player {
  
    // standard currency
    var coin = PlantCoin()
    // special currency
    var seed = GoldenSeed()
    
    static let instance = Player()
    private init() {}
    private init(coin: Int, seed: Int) {
        self.coin.quantity = coin
        self.seed.quantity = seed
    }
    
    internal func add(value: Int, type: Currency) -> Int {
        if(type == .GoldenSeed) {
            return self.seed.quantity + value
        } else {
            return self.coin.quantity + value
        }
        
    }
    
    func pay(price: Int, type: Currency) -> Bool {
        
        if(type == .GoldenSeed && self.seed.quantity >= price) {
            self.seed.quantity -= price
            return true
        } else if(type == .PlantCoin && self.coin.quantity >= price)  {
            self.coin.quantity -= price
            return true
        } else {
            return false
        }
    }
    enum Currency {
        case PlantCoin
        case GoldenSeed
    }
}
 
