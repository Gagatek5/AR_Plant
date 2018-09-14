//
//  PlantEngine.swift
//  ARPlantEngine
//
//  Created by Tom on 14/09/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class PlantEngine {
    
    let player = Player.instance
    
    func wateringPlant(plant: Plant)  {
        if plant.watering + 5 <= 100
        {
            plant.watering += 5
            print(plant.watering)
            
        } else
        {
            plant.watering = 100
            print(plant.watering)
        }
        
    }
    
    func riseUp(rise: Int ,plantStatus: PlantStatus) -> Int {
        var result = 0
        
        if player.activeUpgradesList.keys.contains(.Manure)
        {
            let manure = Manure.init()
            result = manure.manureLevel
            print("result:\(result)")
        }
        switch plantStatus {
        case .theBest:
            result += 10
            break
        case .good:
            result +=  5
            break
        case .neutral:
            break
        case .bad:
            result +=  -2
            break
        case .veryBad:
            result +=  -5
            break
        case .dead:
            return 0
        }
        result += rise
        print("result:\(result)")
        if result >= 0
        {
            return result
        } else{
            return 0
        }
        
    }
    func updatingHealth(health: Int, plantStatus: PlantStatus) -> Int {
        var result = 0
        switch plantStatus {
        case .theBest:
            result = 2
            break
        case .good:
            result =  1
            break
        case .neutral:
            result = 0
            break
        case .bad:
            result =  -1
            break
        case .veryBad:
            result =  -3
            break
        case .dead:
            return 0
        }
        result = health + result
        if result > 0
        {
            return 100
        }else if  result <= 0
        {
            return result
        }else
        {
            return 0
        }
    }
    func updatingInsolation(insolation: Int) -> Int {
        var result = insolation
        if player.activeUpgradesList.keys.contains(.SolarLamp)
        {
            let solar = SolarLamp.init()
            result += solar.solarLevel
            print("result:\(result)")
        }
        if result > 100
        {
            return 100
        }else if  result <= 100
        {
            return result
        }else
        {
            return 0
        }
    }
    func levelUp(rise: Int) -> Int {
        let result = rise/10
        player.add(value: result, type: .PlantCoin)
        if result<=0
        {
            return 1
        }
        return result
    }
    func currentStatus(plant: Plant) -> PlantStatus {
        
        var result: [PlantStatus] = []
        
        switch plant.watering {
        case 90...100:
            result.append(PlantStatus.theBest)
        case 70...89, 101...110:
            result.append(PlantStatus.good)
        case 50...69, 111...125:
            result.append(PlantStatus.neutral)
        case 30...49, 126...140:
            result.append(PlantStatus.bad)
        case 1...29, 141...150:
            result.append(PlantStatus.veryBad)
        case 0:
            result.append(PlantStatus.dead)
        default:
            break
        }
        
        switch plant.health {
        case 80...100:
            result.append(PlantStatus.theBest)
        case 70...79:
            result.append(PlantStatus.good)
        case 50...69:
            result.append(PlantStatus.neutral)
        case 30...49:
            result.append(PlantStatus.bad)
        case 1...29:
            result.append(PlantStatus.veryBad)
        case 0:
            result.append(PlantStatus.dead)
        default:
            break
        }
        
        switch plant.pests.count {
        case 0:
            result.append(PlantStatus.theBest)
        case 1:
            result.append(PlantStatus.bad)
        default:
            result.append(PlantStatus.veryBad)
        }
        
        if result.contains(.dead)
        {
            return .dead
        }else if result.contains(.veryBad)
        {
            return .veryBad
        }else if result.contains(.bad)
        {
            return .bad
        }else if result.contains(.neutral)
        {
            return .neutral
        }else if result.contains(.good)
        {
            return .good
        }else
        {
            return .theBest
        }
    }
    
    func SpawnPests(pest: Pest)
    {
        Plant.instance.pests.append(pest)
    }
}
