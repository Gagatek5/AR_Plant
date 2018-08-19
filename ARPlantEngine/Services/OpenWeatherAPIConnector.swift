//
//  OpenWeatherAPIConnector.swift
//  ARPlantEngine
//
//  Created by Tom on 28/07/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OpenWeatherAPIConnector
{
    static let shared = OpenWeatherAPIConnector()
    private init() {}
    var daysWeathers: [WeatherDayInfo] = []
    let headers: [String:String] = ["appid" : "ad4e521f54b155390c178acc59582f10"]
    
    func getData(longitude: Double, latitiude: Double){
    let URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitiude)&lon=\(longitude)"
    Alamofire.request(URL, parameters: headers).responseJSON {
    response in
        
        let json = JSON(response.result.value!)
        
            
        let day = WeatherDayInfo.init(weather: [Weather.init(main: json["weather"][0]["main"].string!) ])
            print(day)
  
        }
        
        }
    
    }

enum HttpRequestType {
    case POST
    case GET
    case DELETE
    case PATCH
}

