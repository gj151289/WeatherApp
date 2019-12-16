//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Gaurav Joshi on 12/14/19.
//  Copyright © 2019 Gaurav Joshi. All rights reserved.
//

import Foundation
import UIKit

struct WeatherViewModel {
    let temperature : String
    let mainWeatherCondition : String
    let weatherModel : WeatherModel
    
    init(weather : WeatherModel) {
        weatherModel = weather
        self.temperature = "\(String(weather.currentTemp!))"
        self.mainWeatherCondition = String(weather.weatherCondition)
    }
    
    var WeatherConditionImage : UIImage {
        switch weatherModel.weatherCondition {
            
        case "Clouds":
            return UIImage(named:"sea_cloudy")!
            
        case "Clear":
            return UIImage(named:"sea_sunny")!
            
        case "Rain":
            return UIImage(named:"sea_rainy")!
            
        default:
            return UIImage(named:"sea_sunny")!
            
        }
    }
    
    var WeatherConditionColor : UIColor {
        switch weatherModel.weatherCondition {
            
        case "Clouds":
            return hexStringToUIColor(hex: "#54717A")
            
        case "Clear":
            return hexStringToUIColor(hex: "#4A90E2")
            
        case "Rain":
            return hexStringToUIColor(hex: "#57575D")
            
        default:
            return hexStringToUIColor(hex: "#4A90E2")
            
        }
    }
    
    var WeatherConditionText : String {
        switch weatherModel.weatherCondition {
        
        case "Clouds":
            return "CLOUDY"
            
        case "Clear":
            return "SUNNY"
            
        case "Rain":
            return "RAINY"
            
        default:
            return "SUNNY"
        
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
    }
}
