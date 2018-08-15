//
//  Time.swift
//  ARPlantEngine
//
//  Created by Tom on 25/07/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation
class Time
{
    let testPlant = Plant.instance
    func timer(timeInterval: TimeInterval)
    {
        var timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {
            (_) in
            // print("lol")
            if self.testPlant.watering - 2 >= 0
            {
                self.testPlant.watering -= 2
            }
            self.testPlant.rise = self.testPlant.riseUp(rise: self.testPlant.rise, plantStatus: self.testPlant.currentStatus(plant: self.testPlant))
            self.testPlant.health = self.testPlant.updatingHealth(health: self.testPlant.health, plantStatus: self.testPlant.currentStatus(plant: self.testPlant))
            self.testPlant.plantLevel = self.testPlant.levelUp(rise: self.testPlant.rise)
            
            if !Player.instance.activeUpgradesList.isEmpty {
                for item in Player.instance.activeUpgradesList {
                    var timeLeft = item.value - Int(timeInterval)
                    Player.instance.activeUpgradesList.updateValue(timeLeft, forKey: item.key)
                    print(item)
                    if(timeLeft <= 0) {
                        Player.instance.activeUpgradesList.removeValue(forKey: item.key)
                    }
                }
            }
        }
    }
}
