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
    func timer()
    {
        var timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {
            (_) in
            print("lol")
            if self.testPlant.watering >= 0
            {
                self.testPlant.watering -= 2
            }
            self.testPlant.rise = self.testPlant.riseUp(rise: self.testPlant.rise, plantStatus: self.testPlant.currentStatus(plant: self.testPlant))
            self.testPlant.health = self.testPlant.updatingHealth(health: self.testPlant.health, plantStatus: self.testPlant.currentStatus(plant: self.testPlant))
            self.testPlant.plantLevel = self.testPlant.levelUp(rise: self.testPlant.rise)
//            if self.sceneView.scene.rootNode.childNode(withName: "plant", recursively: false) != nil
//            {
//                if self.level < self.testPlant.plantLevel
//                {
//                    self.autoRiseUp()
//                }else{
//                    self.autoRiseDown()
//                }
//
//                self.level = self.testPlant.plantLevel
//            }
        }
    }
}
