//
//  Converter.swift
//  ARPlantEngine
//
//  Created by Tom on 10/08/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation

enum Direction: String {
    case N
    case NNE
    case NE
    case ENE
    case E
    case ESE
    case SE
    case SSE
    case S
    case SSW
    case SW
    case WSW
    case W
    case WNW
    case NW
    case NNW
}

class Converter {
    
    static let shared = Converter()
    private init() {}
    
    func convertDegToDir(deg: Int) -> Direction{
        switch deg {
        case 349..<361, 0..<11:
            return Direction.N
        case 11..<34:
            return Direction.NNE
        case 34..<56:
            return Direction.NE
        case 56..<79:
            return Direction.ENE
        case 79..<101:
            return Direction.E
        case 101..<124:
            return Direction.ESE
        case 124..<146:
            return Direction.SE
        case 146..<169:
            return Direction.SSE
        case 169..<191:
            return Direction.S
        case 191..<214:
            return Direction.SSW
        case 214..<236:
            return Direction.SW
        case 236..<259:
            return Direction.WSW
        case 259..<281:
            return Direction.W
        case 281..<304:
            return Direction.WNW
        case 304..<326:
            return Direction.NW
        case 326..<349:
            return Direction.NNW
        default:
            return Direction.E
        }
    }
    func dataDay(dayNumber: Int) -> String
    {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = dayNumber
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        
        let dataDay = dateFormatter.string(from: futureDate!)
        
        return dataDay
    }
    
}
