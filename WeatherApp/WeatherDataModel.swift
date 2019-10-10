//
//  weatherDataModel.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 10/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import Foundation

struct WeatherDataModel : Codable {
    var name : String
    var weather : [Weather]
    var main : Main
    
}

struct Weather : Codable {
    var description : String
    var icon : String
    var main : String
}

struct Main : Codable {
    var temp : Double
}
