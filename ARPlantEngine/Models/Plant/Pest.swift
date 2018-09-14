//
//  Pest.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

struct Pest {
    
    var name: String
    var harmfulness: Int
    
    init(names: Pests) {
        name = names.rawValue
        harmfulness = 3
    }
    
    func CalculateTime() {
        Plant.instance.spawnPestsTime = Int(arc4random_uniform(3) + 1) *  3600
    }
}

enum Pests: String
{
    case Greenfly = "Greenfly"
    case FireAnt = "Fire ant"
}


