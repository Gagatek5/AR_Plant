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
    var daysWeathers: [DayWeather] = []
    let headers: [String:String] = ["appid" : "ad4e521f54b155390c178acc59582f10"]
    
    func getData(longitude: Double, latitiude: Double){
    let URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitiude)&lon=\(longitude)"
    Alamofire.request(URL, parameters: headers).responseJSON {
    response in
    
        let json = JSON(response.result.value!)
        
            
//            let day = DayWeather.init(
//                date: json["dt"].stringValue,
//                temp: json["temp"]["day"].intValue,
//                tempMax: json["temp"]["max"].intValue,
//                tempMin: json["temp"]["min"].intValue,
//                pressure: json["pressure"].intValue,
//                image: UIImage(data: try! Data(contentsOf: NSURL(string: "http://openweathermap.org/img/w/\(json["weather"][0]["icon"].stringValue).png")! as URL) as Data)!,
//                humidity: json["humidity"].intValue,
//                windSpeed: json["speed"].intValue,
//                windDirection: Converter.shared.convertDegToDir(deg:(json["deg"].intValue))
//            )
  
        }
        
        }
    
    }

enum HttpRequestType {
    case POST
    case GET
    case DELETE
    case PATCH
}

