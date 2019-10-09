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
    var dataCont : DataController?
    var locationManager : CLLocationManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.locationManager = CLLocationManager()
        let tabController = window?.rootViewController as! UITabBarController
        
        let curController = tabController.viewControllers![0] as! CurrentWeatherController
        let foreController = tabController.viewControllers![1] as! ForecasController
        let cityController = tabController.viewControllers![2] as! CityController
 
        dataCont = DataController()
        
        curController.dataController = self.dataCont
        foreController.dataController = self.dataCont
        cityController.dataController = self.dataCont
        
        self.locationManager!.delegate = self
        locationManager!.requestAlwaysAuthorization()
        self.locationManager!.startUpdatingLocation()
        
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations.last
        let lat = loc!.coordinate.latitude
        let lon = loc!.coordinate.longitude
        print(lat)
        print(lon)
        dataCont!.longitude = lon
        dataCont!.latitude = lat
        dataCont!.fethlocations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.dataCont!.getWeather()
        }
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


}

