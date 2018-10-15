//
//  Location.swift
//  WeatherApp
//
//  Created by Kristijan Ivanov on 10/20/17.
//  Copyright © 2017 Dare. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
