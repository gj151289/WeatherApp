//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Gaurav Joshi on 12/14/19.
//  Copyright © 2019 Gaurav Joshi. All rights reserved.
//

import Foundation

struct WeatherModel
{
    let id : Int?
    let stringDate : String?
    let currentTemp: Double!
    let minTemp: Double!
    let maxTemp: Double!
    let timeZone : Int!
    let weatherCondition : String
    let weatherDescription : String?
    
    init(weatherData : [String:AnyObject] ) {
        let main = weatherData["main"] as! [String: AnyObject]
        let weatherInfo = weatherData["weather"] as! [[String: AnyObject]]
        
        self.id = weatherData["id"] as? Int
        self.stringDate = weatherData["dt_txt"] as? String
        self.currentTemp = main["temp"] as? Double
        self.minTemp = main["temp_min"] as? Double
        self.maxTemp = main["temp_max"] as? Double
        self.timeZone = weatherData["timezone"] as? Int
        self.weatherCondition = weatherInfo[0]["main"] as! String
        self.weatherDescription = weatherInfo[0]["description"] as? String
     
    }
    
}
