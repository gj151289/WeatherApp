//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Gaurav Joshi on 12/14/19.
//  Copyright © 2019 Gaurav Joshi. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherViewModel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expect = expectation(description: "")
        guard let weatherURL = URL(string: "\(OpenWeatherLink.ROOT_URL)\(OpenWeatherLink.PRESENT_DAY_URL)?APPID=\(Constants.WEATHER_APP_ID_KEY)&lat=\(13.898)&lon=\(75.674)&units=metric") else { return }
        var request = URLRequest(url: weatherURL)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("error=\(error!)")
                return
            }
            print("Data : \(data)")
            let httpResponse = response as! HTTPURLResponse
            print(httpResponse.statusCode)
            XCTAssertEqual(httpResponse.statusCode, 200)
            expect.fulfill()
        }
        task.resume()
        
        waitForExpectations(timeout: 5.0) { (error) in
            if error != nil {
                XCTFail(error!.localizedDescription)
            }
        }
    }
}
