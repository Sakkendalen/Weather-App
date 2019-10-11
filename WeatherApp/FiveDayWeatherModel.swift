//
//  weatherDataModel.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 10/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import Foundation

struct FiveDayWeatherModel : Codable {
    let list : [FiveDayWeatherList]
}

struct FiveDayWeatherList : Codable {
    let dt : Date
    let main : FiveDayMain
    let weather : [FiveDayWeather]
    //let dt_Txt : String
}

struct FiveDayWeather : Codable {
    let id : Int
    var icon : String
    var main : String
    var description : String
}

struct FiveDayMain : Codable {
    var temp : Double
}
