//
//  Obtainable.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

// klasa nadrzedna dla wszystkich rzeczy mozliwych do kupienia
protocol Obtainable {
    
    var name: String { get set }
    var price: Int { get set }
    var currency: CurrencyType { get set }
    // var image: UIImage { get set }
}
