//
//  Constants.swift
//  WeatherApp
//
//  Created by Gaurav Joshi on 12/15/19.
//  Copyright © 2019 Gaurav Joshi. All rights reserved.
//

import Foundation

enum Constants {
    /**
    The OpenWeatherMap  "APP_ID_KEY"
    - WEATHER_APP_ID : This is private APP_KEY to access  OpenWeatherMap API data.
    */
     static let WEATHER_APP_ID_KEY = "MY_OPEN_WEATHER_MAP_API_KEY"
}

struct OpenWeatherLink {
    /**
     The Openweather API
     - ROOT_URL : This is base URL for OpenWeatherMap API
     - PRESENT_DAY_URL : This is Waether API to get current weather report
     - FORECAST_URL : The complete string url for Forecast for next 5 days
     */
    static let ROOT_URL = "http://api.openweathermap.org/data/2.5/";
    static let PRESENT_DAY_URL = "weather";
    static let FORECAST_URL = "forecast";
}
