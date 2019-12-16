//
//  DataUtility.swift
//  WeatherApp
//
//  Created by Gaurav Joshi on 12/14/19.
//  Copyright © 2019 Gaurav Joshi. All rights reserved.
//

import Foundation
import CoreLocation


class DataUtility : NSObject, CLLocationManagerDelegate  {
    
    static var sharedInstance = DataUtility()
    var locationManager : CLLocationManager!
    private let weatherFetch : WeatherDataFetch = WeatherDataFetch()
    
    private override init() {
        super.init()
    }
    
    private (set) var coordinates : CLLocation? {
        didSet {
            NotificationCenter.default.post(name: .postLocation, object: nil, userInfo:nil)
        }
    }
    
    private (set) var weatherModel : [String:WeatherModel]? {
        didSet {
            NotificationCenter.default.post(name: .weatherModelPrepared, object: nil, userInfo:self.weatherModel)
        }
    }
    
    private (set) var forecastModel : [String:Forecast5Model]? {
        didSet {
            NotificationCenter.default.post(name: .forecastModelPrepared, object: nil, userInfo:self.forecastModel)
        }
    }
    
    
    /**
     Method that calls Location services to fetch current user's location using CLLocationManager . This method initaites services in order to get Lat, Long values for user
     */
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 1000
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
           // locationManager.requestWhenInUseAuthorization()
        }
    }
    
    /**
     Method to start tracking  Location services to fetch current user's location using CLLocationManager . This method is called as soon as app finishes its launch on device.
     */
    func start () {
        setupLocationManager()
    }
    
    // MARK: CLLocationManager Delegate Functions
    
    //Location manager to manage location services and collect geo co-ordinates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location  = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        self.coordinates = location
    }
    
    //Location manager method if it fails to get geo co-ordinates
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NotificationCenter.default.post(name: .locationError, object: nil)
        debugPrint(error.localizedDescription)
    }
    
    /**
     Method to fetch data related to Weather API. This method uses lat, long co-ordinates to get current Weather reports and populate data in WeatherModel. If request fails or gets some error it prints error message.
     */
    func requestWeather() {
        guard let coordinates = self.coordinates else {
            return
        }
        self.weatherFetch.getCurrentWeatherByCoordinates( lat: String(coordinates.coordinate.latitude), long: String(coordinates.coordinate.longitude), successHandler: { (weatherModel) in
            self.weatherModel = ["dataModel":weatherModel]
        }) { (error) in
            debugPrint(error.localizedDescription)
        }
    }
    
    /**
     Method to fetch data related to forecast API for next 5 days. This method uses lat, long co-ordinates to get current Weather reports and populate data in forecastModel. If request fails or gets some error it prints error message.
     */
    func requestForecast() {
        guard let coordinates = self.coordinates else {
            return
        }
        self.weatherFetch.getForecastByCoordinates(lat: String(coordinates.coordinate.latitude), long: String(coordinates.coordinate.longitude), successHandler: { (forecastModel) in
            self.forecastModel = ["forecastModel":forecastModel]
        }) { (error) in
            debugPrint(error.localizedDescription)
        }
    }
    
    // This function helps to get week day from Calendar while returning string in response
    static func getWeekDayfromCalendarElement(element: Int) -> String {
        
        switch element {
            
        case 1:
            return "Sunday"
            
        case 2:
            return "Monday"
            
        case 3:
            return "Tuesday"
            
        case 4:
            return "Wednesday"
            
        case 5:
            return "Thursday"
            
        case 6:
            return "Friday"
            
        case 7:
            return "Saturday"
            
        default:
            return ""
        }
    }
    
    // Function to return dateformatter in YYYY-MM-dd HH:mm:ss format
    private static func dateFormatter () -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    // Function to return timestamp from calendar 
    static func fromTimestampToCalendarElement(timestamp: String?, component:Calendar.Component ) -> Int {
        guard let timestampExists = timestamp else {
            return -1
        }
        return Calendar.current.component(component, from: dateFormatter().date(from: timestampExists)!)
    }
    
}

// MARK: Extension to name NOTIFICATION used in app to broadcast info.
extension Notification.Name {
    static let postLocation = Notification.Name("geoLocation")
    static let locationError = Notification.Name("error")
    static let weatherModelPrepared = Notification.Name("weatherSet")
    static let forecastModelPrepared = Notification.Name("forecastSet")
}
