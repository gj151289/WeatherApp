//
//  HomeScreen.swift
//  WeatherApp
//
//  Created by Gaurav Joshi on 12/14/19.
//  Copyright © 2019 Gaurav Joshi. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class HomeScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var labelMinTemp: UILabel!
    
    @IBOutlet weak var labelCurrentTemp: UILabel!
    
    @IBOutlet weak var backgroundWeatherImg: UIImageView!
    
    @IBOutlet weak var bottomViewBackgroundColor: UIView!
    
    @IBOutlet weak var labelMaxTemp: UILabel!
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    @IBOutlet weak var labelTodaysTemp: UILabel!
    
    @IBOutlet weak var labelTodaysWeather: UILabel!
    
    var weatherViewModel : WeatherViewModel!
    
    var dataModel: Forecast5Model!
    
    
    // MARK: Methods for Viewcontroller life-cycle
    override func loadView() {
        super.loadView()
        addNotificationsObservers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.forecastTableView.tableFooterView = UIView()
        self.forecastTableView.register(UINib(nibName: "ForecastCustomCell", bundle: nil), forCellReuseIdentifier: "forecastCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Method to add Notification Observers
    func addNotificationsObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(setWeatherModel), name: .weatherModelPrepared, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorGettingGeoCoordinates), name: .locationError, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setForecastModel), name: .forecastModelPrepared, object: nil)
    }

    //Function to display data on view for Weather API
    @objc func setWeatherModel(notification:NSNotification) {
        let dataModel : WeatherModel = notification.userInfo?["dataModel"] as! WeatherModel
        self.weatherViewModel = WeatherViewModel(weather: dataModel)
        self.backgroundWeatherImg.image = self.weatherViewModel.WeatherConditionImage
        self.bottomViewBackgroundColor.backgroundColor = self.weatherViewModel.WeatherConditionColor;
        let presentTemp = Double(self.weatherViewModel.temperature)
        self.labelTodaysTemp.text = "\(Int(presentTemp!.rounded()))°"
        self.labelTodaysWeather.text = self.weatherViewModel.WeatherConditionText
        self.labelCurrentTemp.text = "\(Int(self.weatherViewModel.weatherModel.currentTemp!.rounded()))°\nCurrent";
        self.labelMinTemp.text = "\(Int(self.weatherViewModel.weatherModel.minTemp!.rounded()))°\nmin";
        self.labelMaxTemp.text = "\(Int(self.weatherViewModel.weatherModel.maxTemp!.rounded()))°\nmax";
    }
    
    //Function to display data on view for Forecast API
    @objc func setForecastModel(notification:NSNotification) {
        dataModel = notification.userInfo?["forecastModel"] as? Forecast5Model
        DispatchQueue.main.async {
            self.forecastTableView.reloadData()
        }
    }
    
    //Function to display error message on view in AlertView for getting Geo Location of user
    @objc func errorGettingGeoCoordinates() {
        let alert = UIAlertController(title: "Error", message: "An error occured while retrieving your position", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        })
        self.present(alert,animated: true)
    }
    
    
    // MARK: UITableview delegate and datasource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.dataModel != nil){
            return  self.dataModel.forecastList.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ForecastCustomCell = self.forecastTableView.dequeueReusableCell(withIdentifier: "forecastCell") as! ForecastCustomCell
        
        let model = ForecastViewModel(forecast: dataModel,index:indexPath.row)
        
        cell.labelDay.text = model.getWeekDay
        let forecastTemp = Double(model.getTemperature)
        cell.labelTemp.text = "\(Int(forecastTemp!.rounded()))°"
        cell.forecastImage.image = model.getWeatherImage
        cell.selectionStyle = .none
        return cell;
    }
    
}

