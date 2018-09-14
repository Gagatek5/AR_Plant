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
    
    var upgradesList: [Int] = [0,0,0]
    
    var activeUpgradesList: [Upgrade:Int] = [:]
    
    let playerStatusDefaults = UserDefaults.standard
    let converter = SaveCurrentStatus()
    
    static let instance = Player()
    
    private init() {
        if playerStatusDefaults.value(forKey: "coin") != nil
        {
            self.coin.quantity = playerStatusDefaults.value(forKey: "coin") as! Int
            self.seed.quantity = playerStatusDefaults.value(forKey: "seed") as! Int
            self.upgradesList =  playerStatusDefaults.value(forKey: "upgradeList") as! [Int]
            
            let temp = playerStatusDefaults.value(forKey: "activeUpgradeList") as! [String:Int]
            
            for item in temp
            {
                self.activeUpgradesList.updateValue(item.value, forKey: converter.convertFromString(upgrade: item.key))
            }
        }
    }
    
    private init(coin: Int, seed: Int, upgradesList: [Int]) {
        self.coin.quantity = coin
        self.seed.quantity = seed
        self.upgradesList = upgradesList
    }
    
    internal func add(value: Int, type: CurrencyType) {
        if(type == .GoldenSeed) {
            self.seed.quantity += value
        } else {
            self.coin.quantity += value
        }
        
    }
    
    func pay(price: Int, type: CurrencyType) -> Bool {
        
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
    
   
}
 
