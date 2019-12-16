# Weather App - iOS(Swift)

Weather app helps user to get weather reports of his current location. App displays current temperature and weather conditions. Current temperature, minimum temperature and maximum temperature of day is also recorded and displayed on screen. User can also see a forecast report of next 5 days. To get latest weather information app uses OpenWeatherMap API. Sea theme is used to present this app and enhance the UI.

  

  
## Prerequisites

Software that needs to be installed on machine

- Xcode : version 11.1

- iOS  : version 13.1

- Mac OS  : version 10.15 (Catalina)

- CocoaPods : This should be installed inside project folder location.

  

  

### Installing Cocoapods
- Open Terminal on Mac Machine

- Run command `sudo gem install cocoapods`

- Enter your admin password for machine

Wait for this to finish, don't touch your terminal. It might take a couple minutes.

- Go to project folder location of your disk

- Run command `pod setup`

  

  

## Build With
- MVVM Architecture

- Xcode IDE

  

#### Colors used for Background
- Sunny Day  : #4A90E2

- Cloudy Day : #54717A

- Rainy Day   : #57575D

 
#### Cocoapods Used

#### Alamofire

While NSURLSession is powerful by itself, [Alamofire](https://github.com/Alamofire/Alamofire) remain surprisingly unbeaten when it comes to actually managing queues of requests, which is pretty much a requirement of any modern app.

  

## XCTest

WeatherAppTests is the swift file used for XCTestcase use. This file checks whether OpenWeatherMap API returns response with status code 200.

  

## Versioning

Used Github for versioning and code repository.
