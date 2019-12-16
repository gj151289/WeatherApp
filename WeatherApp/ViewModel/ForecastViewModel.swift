//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Gaurav Joshi on 12/14/19.
//  Copyright © 2019 Gaurav Joshi. All rights reserved.
//

import Foundation
import UIKit

struct ForecastViewModel {

    var indexValue : Int!
    var forecastList : [WeatherModel]
    var forecastModel : Forecast5Model!
    
    init(forecast : Forecast5Model, index:Int) {
        forecastList = forecast.forecastList
        indexValue = index
        forecastModel = forecast
    }
    
    //Function helps to get string of currentTemperature
    var getTemperature : String {
        return String(forecastList[indexValue].currentTemp)
    }
    
    //Function helps to get String of weekday from Date string as input
    var getWeekDay : String {
        return DataUtility.getWeekDayfromCalendarElement(element:  DataUtility.fromTimestampToCalendarElement(timestamp: forecastList[indexValue].stringDate, component: .weekday))
    }
    
    //Function returns UIImage object of weather Image to display it on Top section of Home screen
    var getWeatherImage : UIImage {
           switch forecastList[indexValue].weatherCondition {
               
           case "Clouds":
               return UIImage(named:"partlysunny")!
               
           case "Clear":
               return UIImage(named:"clear")!
               
           case "Rain":
               return UIImage(named:"rain")!
               
           default:
               return UIImage(named:"clear")!
    
           }
       }
}

