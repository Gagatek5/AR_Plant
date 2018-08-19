//
//  WeatherDayInfo.swift
//  ARPlantEngine
//
//  Created by Tom on 10/08/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//


import Foundation

struct WeatherDayInfo {
    let coord: Coord?
    let sys: Sys?
    let weather: [Weather]?
    let main: Main?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt, id: Int?
    let name: String?
    let cod: Int?
    
    init(weather: [Weather]) {
        self.weather = weather
        coord = nil
        sys = nil
        main = nil
        wind = nil
        rain = nil
        clouds = nil
        dt = nil
        id = nil
        name = nil
        cod = nil
        
        
    }
}

struct Clouds {
    let all: Int?
}

struct Coord {
    let lon, lat: Int?
}

struct Main {
    let temp: Double?
    let humidity, pressure: Int?
    let tempMin, tempMax: Double?
}

struct Rain {
    let the3H: Int?
}

struct Sys {
    let country: String?
    let sunrise, sunset: Int?
}

struct Weather {
    let id: Int?
    let main, description, icon: String?
    init(main: String) {
        self.main = main
        id = nil
        description = nil
        icon = nil
    }
}

struct Wind {
    let speed, deg: Double?
}
