//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Kristijan Ivanov on 8/23/17.
//  Copyright © 2017 Dare. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    //MARK: Data Hiding only this class can access it and the download function
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = " Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
  
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
// MARK: Function for downloading data
        func downloadWeatherDetails (completed: @escaping DownloadComplete) {
            // This tells Alamofire where to download from
            Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
                // every request has a response and every response has a result
                let result = response.result
                if let dict = result.value as? Dictionary<String, Any> {
                    if let name = dict["name"] as? String {
                        self._cityName = name.capitalized
                        print(self._cityName)
                    }
                    
                    if let weather = dict["weather"] as? [Dictionary<String,Any>] {
                        if let main = weather[0]["main"] as? String {
                            self._weatherType = main.capitalized
                            print(self._weatherType)
                        }
                    }
                    
                    if let main = dict["main"] as? Dictionary<String,Any> {
                        if let currentTemperature = main["temp"] as? Double {
                            let kelvinToCelsius = (currentTemperature - 273.15)
                            self._currentTemp = kelvinToCelsius.rounded()
                            print(self._currentTemp)
                        }
                    }
                }
                completed()
            }
        }
}
