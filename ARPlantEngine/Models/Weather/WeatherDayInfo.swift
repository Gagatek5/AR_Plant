//
//  WeatherDayInfo.swift
//  ARPlantEngine
//
//  Created by Tom on 10/08/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//


import UIKit

class DayWeather {
    
    // to do
    let date : String
    let temp: Int
    let tempMax: Int
    let tempMin: Int
    let pressure: Int
    let image: UIImage
    let humidity: Int
    let windSpeed: Int
    let windDirection: Direction
    
    init(date:String, temp:Int, tempMax:Int, tempMin:Int, pressure:Int, image:UIImage, humidity:Int, windSpeed:Int, windDirection:Direction ) {
        self.date = date
        self.temp = temp
        self.tempMax = tempMax
        self.tempMin = tempMin
        self.pressure = pressure
        self.image = image
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.windDirection = windDirection
    }
}
//Optional({
//
//    base = stations;
//
//    clouds =     {
//
//        all = 20;
//
//    };
//
//    cod = 200;
//
//    coord =     {
//
//        lat = "54.35";
//
//        lon = "18.62";
//
//    };
//
//    dt = 1532986200;
//
//    id = 3099434;
//
//    main =     {
//
//        humidity = 94;
//
//        pressure = 1019;
//
//        temp = "294.15";
//
//        "temp_max" = "294.15";
//
//        "temp_min" = "294.15";
//
//    };
//
//    name = Gdansk;
//
//    sys =     {
//
//        country = PL;
//
//        id = 5349;
//
//        message = "0.0054";
//
//        sunrise = 1532919311;
//
//        sunset = 1532976450;
//
//        type = 1;
//
//    };
//
//    visibility = 8000;
//
//    weather =     (
//
//        {
//
//            description = "few clouds";
//
//            icon = 02n;
//
//            id = 801;
//
//            main = Clouds;
//
//        }
//
//    );
//
//    wind =     {
//
//        deg = 340;
//
//        speed = "2.1";
//
//    };
//
//})
