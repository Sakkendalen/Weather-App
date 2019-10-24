//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit

class DataController {
    
    var curController : CurrentWeatherController?
    var forController : ForecasController?
    
    
    init(){
        
    }
    
    func fetchWeather(url : String, cont: CurrentWeatherController){
        
        curController = cont
        
        fecthUrl(url: url)
        
        
    }
    
    func fetchForecast(url : String, cont: ForecasController){
        
        forController = cont
        
        fecthUrl(url: url)
        
    }
    
    func locationChanged(command: String){
        curController?.changeLocation(command: command)
        forController?.changeLocation(command: command)
        
    }
    
    func fecthUrl(url: String){
        
        //print("fetch")
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        
        // Execute stuff in UI thread
        if let resstr = String(data: data!, encoding: String.Encoding.utf8){

            //FORECAST
            if resstr.contains("\"cod\":\"200\""){
                do{
                    //let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    //print(json)
                    let model = try JSONDecoder().decode(FiveDayWeatherModel.self, from:data!)
                    //print(model)
                    DispatchQueue.main.async(execute: {() in
                        //self.foreController!.passData(model: model2)
                        self.forController?.fiveDayWeatherArray = model
                    })
                    //print(model2)
                }catch{
                    print(error)
                }
            }
                
            //CURRENT
            else {
                do{
                    //let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    //print(json)
                    let model = try JSONDecoder().decode(WeatherDataModel.self, from:data!)
                    //print(model)
                    
                    self.fetchWeather(url: "https://openweathermap.org/img/wn/\(model.weather[0].icon)@2x.png", cont: curController!)
                    
                    DispatchQueue.main.async(execute: {() in
                        
                        //Assign data to curController attributes
                        self.curController!.desc.text = model.weather[0].description
                        let formatted = String(format: "%.1f", model.main.temp)
                        self.curController!.temperature.text = "  \(formatted) °C"
                        
                    })
                }catch{
                    print(error)
                }
            }
        } else if let image = UIImage(data: data!){
            DispatchQueue.main.async(execute: {() in
                
                self.curController!.image.image = image
                
            })
        }
    }
}
