//
//  Pests.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

class Pest {
    
    // nazwa szkodnika
    var name: String
    // szkodliwosc
    let harmfulness: Int
    
    init(names: Pests) {
        name = names.rawValue
        harmfulness = 3
    }
    // enum ze stalymi wartosciami, rozne szkodniki ze stalymi okreslajacymi ich szkodliwosc
   /* enum pestNames: Pests {
        case 1 = Pests(name: "mszyca", harmfulness: 1),
        case 2 = Pests(name = "ognistemrowki", harmfulness: 3),
        case 3 = Pests(name = "latajacejakiescoscojerosliny = veganin?", harmfulness: 5),
        case 4 = Pests(name = "ogolnie jakis tam BOSS co niszczy rosline, bo nie lubi vege", harmfulness: 8)*/
    }
enum Pests: String
{
    case Greenfly = "Greenfly"
    case FireAnt = "Fire ant"
}


