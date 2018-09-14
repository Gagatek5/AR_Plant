//
//  SaveCurrentStatus.swift
//  ARPlantEngine
//
//  Created by Tom on 21/08/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class SaveCurrentStatus {
    let StatusDefaults = UserDefaults.standard
    
   private func savePlantStatus() {
        var pestsName:[String] = []
        
        for pest in Plant.instance.pests {
            pestsName.append(pest.name)
        }
        
        StatusDefaults.set(pestsName, forKey: "pests")
        StatusDefaults.set(Plant.instance.name.rawValue, forKey: "name")
        StatusDefaults.set(Plant.instance.watering, forKey: "watering")
        StatusDefaults.set(Plant.instance.health, forKey: "health")
        StatusDefaults.set(Plant.instance.insolation, forKey: "insolation")
        StatusDefaults.set(Plant.instance.rise, forKey: "rise")
        StatusDefaults.set(Plant.instance.plantLevel, forKey: "plantLevel")
        StatusDefaults.set(Plant.instance.spawnPestsTime, forKey: "spawnPestsTime")
    }
    
    private func savePlayerStatus() {
        var activeUpgradeStatus:[ String:Int] = [:]
        
        if Player.instance.activeUpgradesList.count > 0 {
            for item in Player.instance.activeUpgradesList {
                activeUpgradeStatus.updateValue(item.value, forKey: convertToString(upgrade:item.key))
            }
        }
        
        StatusDefaults.set(Player.instance.coin.quantity, forKey: "coin")
        StatusDefaults.set(Player.instance.seed.quantity, forKey: "seed")
        StatusDefaults.set(Player.instance.upgradesList, forKey: "upgradeList")
        StatusDefaults.set(activeUpgradeStatus, forKey: "activeUpgradeList")
    }
    
    private func saveDate() {
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        let currentDate = [month, day, hour, minutes, seconds]
        
        StatusDefaults.set(currentDate, forKey: "currentDate")
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
    
    func convertNameToPlants(plantName: String)-> Plants {
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
    
    func convertNameToPests(pestName: String)-> Pests {
        switch pestName{
        case "Fire ant":
            return .FireAnt
        case "Greenfly":
            return .Greenfly
        default:
            return .FireAnt
        }
    }
    func saveStatus() {
        self.savePlayerStatus()
        self.savePlantStatus()
        self.saveDate()
    }
}

