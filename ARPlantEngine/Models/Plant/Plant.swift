//
//  Plant.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class Plant: PlantEngine {
    
    let plantStatusDefaults = UserDefaults.standard
    let converter = SaveCurrentStatus()
    
    let name: Plants
    var watering: Int
    var health: Int
    var insolation: Int
    var pests: [Pest] = []
    var rise: Int
    var plantLevel: Int
    var spawnPestsTime: Int? = nil
    var xSize:Float = 0.0
    var ySize:Float = 0.0
    var zSize:Float =  0.0
    
    static let instance = Plant(name: .bonsai)
    private init(name: Plants) {
        if plantStatusDefaults.value(forKey: "name") != nil
        {
            self.name = converter.convertNameToPlants(plantName:  plantStatusDefaults.value(forKey: "name") as! String)
            watering = plantStatusDefaults.value(forKey: "watering") as! Int
            health =  plantStatusDefaults.value(forKey: "health") as! Int
            insolation =  plantStatusDefaults.value(forKey: "insolation") as! Int
            rise = plantStatusDefaults.value(forKey: "rise") as! Int
            plantLevel = plantStatusDefaults.value(forKey: "plantLevel") as! Int
            spawnPestsTime = plantStatusDefaults.value(forKey: "spawnPestsTime") as? Int
            let pests = plantStatusDefaults.value(forKey: "pests") as! [String]
            
            for pest in pests
            {
                self.pests.append(Pest.init(names:converter.convertNameToPests(pestName:pest)))
            }
        } else
        {
            self.name = name
            watering = 80
            health = 100
            insolation = 50
            pests = []
            rise = 1
            plantLevel = 1
        }
    }

}

enum Plants: String
{
    case sunflower = "Sunflower"
    case cactus = "Cactus"
    case bonsai = "Bonsai tree"
}

enum PlantStatus
{
    case theBest
    case good
    case neutral
    case bad
    case veryBad
    case dead
    
}
