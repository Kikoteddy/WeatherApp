//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Kristijan Ivanov on 8/15/17.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    //MARK: IBOUTLETS
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
     let locationManager = CLLocationManager()
     var currentLocation: CLLocation!
     
     var forecasts = [Forecast]()
     var currentWeather: CurrentWeather!
     var forecast: Forecast!

    override func viewDidLoad() {
        super.viewDidLoad()
     
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
}
     
     override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          locationAuthStatus(){
               self.currentWeather.downloadWeatherDetails {
                    self.downloadForecastData {
                         self.updateMainUI()
                    }
               }
          }
     }
     
     func locationAuthStatus(completion: @escaping ()->()) {
          if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
               currentLocation = locationManager.location
               Location.sharedInstance.latitude = currentLocation.coordinate.latitude
               Location.sharedInstance.longitude = currentLocation.coordinate.longitude
               completion()
          } else {
              locationManager.requestWhenInUseAuthorization()
               locationAuthStatus(){
                    self.currentWeather.downloadWeatherDetails {
                         self.downloadForecastData {
                              self.updateMainUI()
                         }
                    }
               }
          }
     }
     
   //MARK: Function for downloading forecast weather data for Tableview
    
    func downloadForecastData(completed: @escaping  DownloadComplete) {

          Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
          
            if let dict = result.value as? Dictionary<String, Any> {
               
               if let list = dict["list"] as? [Dictionary<String,Any>] {
                    
                    for obj in list {
                         
                         let forecast = Forecast(weatherDict: obj)
                         self.forecasts.append(forecast)
                         print(obj)
                         
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
               }
          }
          completed()
     }
}

    //MARK: Tableview main 3 functions delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
          
          let forecast = forecasts[indexPath.row]
          cell.configureCell(forecast: forecast)
          return cell
     } else {
          return WeatherCell()
       }
   }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
}
