//
//  Currency.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 14.08.2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

protocol Currency {

    var quantity: Int { get set }
    
    func add(value: Int)->Int
    
    func pay(price: Int)->Bool
    
}
