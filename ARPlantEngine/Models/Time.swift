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
            wateringUpdate(usedWater: -2)
            plantStatusUpdate()
            itemRemoval(timeInterval: Int(timeInterval))
            addPests(timeInterval: Int(timeInterval))
        }
        func wateringUpdate(usedWater: Int){
            if self.testPlant.watering + usedWater >= 0
            {
                self.testPlant.watering += usedWater
            }
        }
        func plantStatusUpdate(){
            self.testPlant.rise = self.testPlant.riseUp(rise: self.testPlant.rise, plantStatus: self.testPlant.currentStatus(plant: self.testPlant))
            self.testPlant.health = self.testPlant.updatingHealth(health: self.testPlant.health, plantStatus: self.testPlant.currentStatus(plant: self.testPlant))
            self.testPlant.plantLevel = self.testPlant.levelUp(rise: self.testPlant.rise)
            self.testPlant.insolation = self.testPlant.updatingInsolation(insolation: self.testPlant.insolation)
        }
        func itemRemoval(timeInterval: Int)
        {
            if !Player.instance.activeUpgradesList.isEmpty {
                for item in Player.instance.activeUpgradesList {
                    let timeLeft = item.value - timeInterval
                    Player.instance.activeUpgradesList.updateValue(timeLeft, forKey: item.key)
                    print(item)
                    if(timeLeft <= 0) {
                        Player.instance.activeUpgradesList.removeValue(forKey: item.key)
                    }
                }
            }
        }
        func addPests(timeInterval: Int){
            let pest = Pest(names: .FireAnt)
            if self.testPlant.spawPestsTime == nil
            {
               pest.CalculateTime()
            }
            if self.testPlant.spawPestsTime! > 0
            {
                self.testPlant.spawPestsTime! -= timeInterval
            }else
            {
                if  Player.instance.activeUpgradesList.keys.contains(Upgrade.InsectRepelent) == false
                {
                    self.testPlant.SpawnPests(pest: pest)
                    pest.CalculateTime()
                }else
                {
                    pest.CalculateTime()
                }
            }
            print(self.testPlant.spawPestsTime ?? "no value")
        }
        
        
    }
}

