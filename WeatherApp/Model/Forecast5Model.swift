//
//  Forecast5Model.swift
//  WeatherApp
//
//  Created by Gaurav Joshi on 12/14/19.
//  Copyright © 2019 Gaurav Joshi. All rights reserved.
//

import Foundation

struct Forecast5Model  {

    var forecastList : [WeatherModel]!
    
    init(data: [String: AnyObject]) {
        let list = data["list"] as! [[String : AnyObject]]
        self.forecastList = parseWeatherItems(list: list)
    }

    private func parseWeatherItems(list: [[String:AnyObject]]) -> [WeatherModel] {
        var unfilteredList : [WeatherModel] = []
        for obj in list {
            let weatherItem = WeatherModel(weatherData: obj)
            unfilteredList.append(weatherItem)
        }
        return unfilteredList.filter({DataUtility.fromTimestampToCalendarElement(timestamp: $0.stringDate, component: .hour) == 9 })
    }
}
