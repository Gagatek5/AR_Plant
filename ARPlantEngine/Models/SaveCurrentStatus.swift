//
//  SaveCurrentStatus.swift
//  ARPlantEngine
//
//  Created by Tom on 21/08/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class SaveCurrentStatus
{
    let StatusDefaults = UserDefaults.standard
    
    func savePlantStatus()
    {
        var pestsName:[String] = []
        
        for pest in Plant.instance.pests
        {
            pestsName.append(pest.name)
        }
        
        StatusDefaults.set(pestsName, forKey: "pests")
        StatusDefaults.set(Plant.instance.name.rawValue, forKey: "name")
        StatusDefaults.set(Plant.instance.watering, forKey: "watering")
        StatusDefaults.set(Plant.instance.health, forKey: "health")
        StatusDefaults.set(Plant.instance.insolation, forKey: "insolation")
        StatusDefaults.set(Plant.instance.rise, forKey: "rise")
        StatusDefaults.set(Plant.instance.plantLevel, forKey: "plantLevel")
        
    }
    
    func savePlayerStatus()
    {
        var activeUpgradeStatus:[ String:Int] = [:]
        if Player.instance.activeUpgradesList.count > 0
        {
            for item in Player.instance.activeUpgradesList
            {
                activeUpgradeStatus.updateValue(item.value, forKey: convertToString(upgrade:item.key))
            }
        }
        
        StatusDefaults.set(Player.instance.coin.quantity, forKey: "coin")
        StatusDefaults.set(Player.instance.seed.quantity, forKey: "seed")
        StatusDefaults.set(Player.instance.upgradesList, forKey: "upgradeList")
        StatusDefaults.set(activeUpgradeStatus, forKey: "activeUpgradeList")
        
        print(StatusDefaults.value(forKey: "coin"))
        print(StatusDefaults.value(forKey: "seed"))
        print(StatusDefaults.value(forKey: "upgradeList") as! [Int])
        print(StatusDefaults.value(forKey: "activeUpgradeList") as! [String:Int])
        
        
    }
    
    func convertToString(upgrade: Upgrade ) -> String {
        
        switch upgrade {
        case .InsectRepelent :
            return "InsectRepelent"
        case .Manure :
            return "Manure"
        case .SolarLamp:
            return "SolarLamp"
        }
    }
    
    func convertFromString(upgrade: String ) -> Upgrade {
        
        switch upgrade {
        case  "InsectRepelent":
            return .InsectRepelent
        case  "Manure":
            return .Manure
        case "SolarLamp":
            return .SolarLamp
        default:
            return .Manure
        }
    }
    
    func convertNameToPlants(plantName: String)-> Plants
    {
        switch plantName{
        case "Sunflower":
            return .sunflower
        case "Cactus":
            return .cactus
        case "Bonsai tree":
            return .bonsai
        default:
            return .bonsai
        }
    }
    
    func convertNameToPests(pestName: String)-> Pests
    {
        switch pestName{
        case "Fire ant":
            return .FireAnt
        case "Greenfly":
            return .Greenfly
        default:
            return .FireAnt
        }
    }
    
}
