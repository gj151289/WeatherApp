//
//  WeatherDataFetch.swift
//  WeatherApp
//
//  Created by Gaurav Joshi on 12/14/19.
//  Copyright © 2019 Gaurav Joshi. All rights reserved.
//

import Foundation
import Alamofire


class WeatherDataFetch {
    
    //Init method for WeatherDataFetch Class
    init() {}
    
    /**
     Method that returns complete String for Weather URL
     - lat : User's Current latitude
     - long : User's Current longitude
     */
    func weatherCompleteUrl(lat:String, long:String) -> String {
        return "\(OpenWeatherLink.ROOT_URL)\(OpenWeatherLink.PRESENT_DAY_URL)?APPID=\(Constants.WEATHER_APP_ID_KEY)&lat=\(lat)&lon=\(long)&units=metric"
    }
    
    /**
     Method that returns complete String for Forecast URL
     - lat : User's Current latitude
     - long : User's Current longitude
     */
    func forecastCompleteUrl(lat:String,long:String) -> String {
        return "\(OpenWeatherLink.ROOT_URL)\(OpenWeatherLink.FORECAST_URL)?APPID=\(Constants.WEATHER_APP_ID_KEY)&lat=\(lat)&lon=\(long)&units=metric"
    }
    
    /**
     Method that calls API to fetch current weather based on user's location. This method returns object parsed in JSON response or if failed returns error message.
     - lat : User's Current latitude
     - long : User's Current longitude
     */
    func getCurrentWeatherByCoordinates(lat:String, long:String, successHandler:@escaping (WeatherModel) -> Void, errorHandler:@escaping (Error) -> Void) {
        
        Alamofire.request((weatherCompleteUrl(lat: lat, long: long)),encoding: JSONEncoding.default).responseJSON { response in
            
            if let status = response.response?.statusCode{
                
                switch (status){
                    
                case 200:
                    if let result = response.result.value {
                        let json = result as! NSDictionary
                        let weatherItem = WeatherModel(weatherData:json as! [String : AnyObject])
                        successHandler(weatherItem)
                        debugPrint(result)
                    }
                    break
                    
                default:
                    guard let error = response.error else {
                        return
                    }
                    errorHandler(error)
                    debugPrint(error)
                    break
                }
            }
        }
    }
    
    /**
     Method that calls API to fetch forecast weather for next 5 days based on user's location. This method returns object parsed in JSON response or if failed returns error message.
     - lat : User's Current latitude
     - long : User's Current longitude
     */
    func getForecastByCoordinates(lat:String, long:String,successHandler:@escaping (Forecast5Model) -> Void, errorHandler:@escaping (Error) -> Void) {
        
        Alamofire.request((forecastCompleteUrl(lat: lat, long: long)),encoding: JSONEncoding.default).responseJSON { response in
            if let status = response.response?.statusCode{
                
                switch (status){
                    
                case 200:
                    if let result = response.result.value {
                        let json = result as! NSDictionary
                        let forecastItem = Forecast5Model(data: json as! [String : AnyObject])
                        successHandler(forecastItem)
                    }
                    break
                    
                default:
                    guard let error = response.error else {
                        return
                    }
                    errorHandler(error)
                    debugPrint(error)
                    break
                }
            }
        }
    }
}
