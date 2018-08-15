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
    
    init(coin: Int, seed: Int) {
        self.coin.quantity = coin
        self.seed.quantity = seed
    }
    
}
