//
//  Plant.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class Plant {
    
    let plantStatusDefaults = UserDefaults.standard
    let converter = SaveCurrentStatus()
    let p = Player.instance
    
    // nazwa rosliny
    let name: Plants
    // procent nawodenienia
    var watering: Int
    // maksymalny poziom nawodnienia
    var maxWatering = 150
    // minimalny poziom nawodnienia
//    let minWatering = 0
    // ogolna kondycja rosliny
    var health: Int
    // maksymalna kondycja rosliny
    var maxHealth = 100
    // minimalny poziom zdrowia
    let minHealth = 0
    // naslonecznienie
    var insolation: Int
    // maksymalne nasłonecznienie
    var maxInsolation = 100
    // minimalne nasłonecznienie
    let minInsolation = 0
    // poziom zarobaczenia
    var pests: [Pest] = []
    // aktualny poziom wzrostu
    var rise: Int
    //minimalny poziom wzrostu
    let minRise = 0
    // aktualny level roslinki
    var plantLevel: Int
    // czas dodania szkodnika
    var spawnPestsTime: Int? = nil
    // wielkosc x node
    var xSize:Float = 0.0
    // wielkosc y node
    var ySize:Float = 0.0
    // wielkosc z node
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
    
    func wateringPlant(plant: Plant)  {
        if plant.watering + 5 <= plant.maxWatering
        {
            plant.watering += 5
            print(plant.watering)
            
        } else
        {
            plant.watering = plant.maxWatering
            print(plant.watering)
        }
        
    }
    func riseUp(rise: Int, plantStatus: PlantStatus) -> Int {
        var result = 0
        
        if p.activeUpgradesList.keys.contains(.Manure)
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
            return minRise
        }
        result += rise
        print("result:\(result)")
        if result >= minRise
        {
            return result
        } else{
            return minRise
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
            return minHealth
        }
        result = health + result
        if result > maxHealth
        {
            return maxHealth
        }else if  result <= maxHealth
        {
            return result
        }else
        {
            return minHealth
        }
    }
    func updatingInsolation(insolation: Int) -> Int {
        var result = insolation
        if p.activeUpgradesList.keys.contains(.SolarLamp)
        {
            let solar = SolarLamp.init()
            result += solar.solarLevel
            print("result:\(result)")
        }
        if result > maxInsolation
        {
            return maxInsolation
        }else if  result <= maxInsolation
        {
            return result
        }else
        {
            return minInsolation
        }
    }
    func levelUp(rise: Int) -> Int {
       let result = rise/10
        p.add(value: result, type: .PlantCoin)
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

        default: break
            
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
            
        default: break
            
        }
        switch plant.pests.count {
        case 0:
            result.append(PlantStatus.theBest)
        case 1:
            result.append(PlantStatus.bad)
        default:
            result.append(PlantStatus.veryBad)
        }
       //print("result: \(result)")
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
        self.pests.append(pest)
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
