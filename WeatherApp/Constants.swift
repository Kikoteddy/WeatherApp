//
//  Constants.swift
//  WeatherApp
//
//  Created by Kristijan Ivanov on 8/23/17.
//  Copyright © 2017 Dare. All rights reserved.
//

import Foundation

// URL Information
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "f4372bc4f84bece7d6e5bc17fe053c67"

//MARK: typealias to track wheter or not the download has finished
typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=f4372bc4f84bece7d6e5bc17fe053c67"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=f4372bc4f84bece7d6e5bc17fe053c67"
