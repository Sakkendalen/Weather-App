//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import Foundation
import CoreLocation

class DataController {
    
    var latitude : Double?
    var longitude : Double?
    var temp : String?
    var loc : String?
    
    init() {
        
    }
    
    func getWeather(){
        print("nopee")
        let latInt : Double = self.latitude!
        let lonInt : Double = self.longitude!
        print(latInt)
        let session = URLSession.shared
        //Not Working! Nothing to GeoCode!!!
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latInt)&lon\(lonInt)&units=metric&APPID=dc5b74f20581fd613891997b305fcfd2")!
        let dataTask = session.dataTask(with: weatherURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error:\n\(error)")
            } else {
                if let data = data {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print("All the weather data:\n\(dataString!)")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let temperature = mainDictionary.value(forKey: "temp") {
                                DispatchQueue.main.async {
                                    self.temp = "\(temperature)"
                                }
                            }
                        } else {
                            print("Error: unable to find temperature in dictionary")
                        }
                    } else {
                        print("Error: unable to convert json data")
                    }
                } else {
                    print("Error: did not receive data")
                }
            }
        }
        dataTask.resume()
    }
    
    func fethlocations(){
        
        let location = CLLocation(latitude: self.latitude!, longitude: self.longitude!)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                let locString : String = pm.locality!
                self.loc = locString
                print(locString)
            }
            else {
                print("Problem with the data received from geocoder")
            }})
    }
    
}

/*
 //
 //  ViewController.swift
 //  WeatherApp
 //
 //  Created by Saku Tynjälä on 08/10/2019.
 //  Copyright © 2019 Saku Tynjälä. All rights reserved.
 //
 
 import Foundation
 import CoreLocation
 
 class DataController {
 
 var latitude : Double
 var longitude : Double
 var place : String?
 
 init() {
 latitude = 0.0
 longitude = 0.0
 }
 
 func getWeather() -> String{
 let session = URLSession.shared
 //Hox! Atlanta!!
 let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Atlanta,us?&units=metric&APPID=dc5b74f20581fd613891997b305fcfd2")!
 let dataTask = session.dataTask(with: weatherURL) {
 (data: Data?, response: URLResponse?, error: Error?) in
 if let error = error {
 print("Error:\n\(error)")
 } else {
 if let data = data {
 let dataString = String(data: data, encoding: String.Encoding.utf8)
 print("All the weather data:\n\(dataString!)")
 if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
 if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
 if let temperature = mainDictionary.value(forKey: "temp") {
 DispatchQueue.main.async {
 return temperature
 }
 }
 } else {
 print("Error: unable to find temperature in dictionary")
 }
 } else {
 print("Error: unable to convert json data")
 }
 } else {
 print("Error: did not receive data")
 }
 }
 }
 dataTask.resume()
 return ""
 }
 
 func fethlocations() {
 
 print("1\(self.latitude)")
 print("1\(self.longitude)")
 
 let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
 
 CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
 
 if error != nil {
 print("Reverse geocoder failed with error" + error!.localizedDescription)
 return
 }
 
 if placemarks!.count > 0 {
 let pm = placemarks![0]
 self.place = pm.locality
 //print("\(pm.locality!)")
 }
 else {
 print("Problem with the data received from geocoder")
 }})
 }
 
 }
*/
