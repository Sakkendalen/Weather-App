//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    //var dataCont : DataController?
    var locationManager : CLLocationManager?
    var curController : CurrentWeatherController?
    var foreController : ForecasController?
    var cityController : CityController?
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.locationManager = CLLocationManager()
        let tabController = window?.rootViewController as! UITabBarController
        
        curController = tabController.viewControllers![0] as! CurrentWeatherController
        foreController = tabController.viewControllers![1] as! ForecasController
        cityController = tabController.viewControllers![2] as! CityController
        
        /*
        dataCont = DataController()
        
        curController.dataController = self.dataCont
        foreController.dataController = self.dataCont
        cityController.dataController = self.dataCont
         */
        
        self.locationManager!.delegate = self
        locationManager!.requestAlwaysAuthorization()
        self.locationManager!.startUpdatingLocation()
        
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let loc = locations.last
        let lat = self.locationManager?.location!.coordinate.latitude
        let lon = self.locationManager?.location!.coordinate.longitude
        print(lat)
        print(lon)
        fecthUrl(url: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat!)&lon=\(lon!)&units=metric&APPID=dc5b74f20581fd613891997b305fcfd2")
        self.locationManager!.stopUpdatingLocation()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func fecthUrl(url: String){
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        //let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                //print(json)
                let model = try JSONDecoder().decode(WeatherDataModel.self, from:data!)
                //print(model)
                self.passDatatoCurrent(model: model)
            } catch {
                print(error)
            }
        })
    }
    
    func passDatatoCurrent(model: WeatherDataModel){
        curController!.takeData(model: model)
    }
    
    /*
    func getWeather(){
        print("nopee")
        let session = URLSession.shared
        HOX!!! PLACEHOLDER CUPERTINO!!
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=California,us&units=metric&APPID=dc5b74f20581fd613891997b305fcfd2")!
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
        
        let location = CLLocation(latitude: 0.0, longitude: 0.0)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                let locString : String = pm.locality!
                //self.loc = locString
                print(locString)
            }
            else {
                print("Problem with the data received from geocoder")
            }})
    }
 */

}

