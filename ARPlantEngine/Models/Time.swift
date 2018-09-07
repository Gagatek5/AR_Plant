//
//  Time.swift
//  ARPlantEngine
//
//  Created by Tom on 25/07/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation
import ARKit

class Time {
    static let instance = Time()
    private init(){}
    
    let testPlant = Plant.instance
    var counter = 1
    
    func timer(sceneView: ARSCNView) {
        var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            (_) in
            
            if sceneView.scene.rootNode.childNode(withName: "plant", recursively: false) != nil {
                let counter:Float = (Float(self.testPlant.plantLevel) / 10000)
                let plant = (sceneView.scene.rootNode.childNode(withName: "plant", recursively: false))!
                self.testPlant.xSize = plant.scale.x
                self.testPlant.ySize = plant.scale.y
                self.testPlant.zSize = plant.scale.z
                print(counter)
                
                plant.scale = SCNVector3Make(Float(self.testPlant.xSize + counter), Float(self.testPlant.xSize + counter), Float(self.testPlant.xSize + counter))
            }
            
            if self.counter == 5 {
                
                self.wateringUpdate(usedWater: -2)
                self.plantStatusUpdate()
                self.counter = 1
            }
            
            self.itemRemoval()
            self.addPests()
            self.counter += 1
        }
    }
    
    func wateringUpdate(usedWater: Int) {
        if self.testPlant.watering + usedWater >= 0
        {
            self.testPlant.watering += usedWater
        }
    }
    
    func plantStatusUpdate() {
        self.testPlant.rise = self.testPlant.riseUp(rise: self.testPlant.rise, plantStatus: self.testPlant.currentStatus(plant: self.testPlant))
        self.testPlant.health = self.testPlant.updatingHealth(health: self.testPlant.health, plantStatus: self.testPlant.currentStatus(plant: self.testPlant))
        self.testPlant.plantLevel = self.testPlant.levelUp(rise: self.testPlant.rise)
        self.testPlant.insolation = self.testPlant.updatingInsolation(insolation: self.testPlant.insolation)
    }
    
    func itemRemoval() {
        if !Player.instance.activeUpgradesList.isEmpty {
            for item in Player.instance.activeUpgradesList {
                let timeLeft = item.value - 1
                Player.instance.activeUpgradesList.updateValue(timeLeft, forKey: item.key)
                print(item)
                if(timeLeft <= 0) {
                    Player.instance.activeUpgradesList.removeValue(forKey: item.key)
                }
            }
        }
    }
    
    func addPests() {
        let pest = Pest(names: .FireAnt)
        if self.testPlant.spawnPestsTime == nil
        {
            pest.CalculateTime()
        }
        if self.testPlant.spawnPestsTime! > 0
        {
            self.testPlant.spawnPestsTime! -= 1
        }else
        {
            if  Player.instance.activeUpgradesList.keys.contains(Upgrade.InsectRepelent) == false
            {
                self.testPlant.SpawnPests(pest: pest)
                NotificationsController.pestsHasAppearedNotification(pestsAppeared: true)
                pest.CalculateTime()
            }else
            {
                pest.CalculateTime()
            }
        }
        print(self.testPlant.spawnPestsTime ?? "no value")
    }
    
    func CalculateCurrentStatus(time: [Int]) {
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        let currentDate = [month, day, hour, minutes, seconds]
        let multiplyArray = [2592000,86400,3600,60,1]
        var subtractionList:[Int] = []
        var result = 0
        for i in 0...time.count-1
        {
            subtractionList.append(currentDate[i] - time[i])
            print(subtractionList[i])
        }
        for i in 0...subtractionList.count-1
        {
            result += subtractionList[i] * multiplyArray[i]
            print(result)
        }
        test(counters: result)
    }
    
    func test(counters: Int)
    {
        for i in 0...counters
        {
            if i == 180
            {
                self.wateringUpdate(usedWater: -2)
                self.plantStatusUpdate()
            }
            self.itemRemoval()
            self.addPests()
        }
    }
}

