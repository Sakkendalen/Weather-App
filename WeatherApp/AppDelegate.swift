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
    
    var curController : CurrentWeatherController?
    var foreController : ForecasController?
    var cityController : CityController?
    
    var geoCod = CLGeocoder()
    var locations : CLLocationCoordinate2D?
    var location : CLLocation?
    var placeMark: CLPlacemark?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let tabController = window?.rootViewController as! UITabBarController
        
        curController = tabController.viewControllers![0] as! CurrentWeatherController
        foreController = tabController.viewControllers![1] as! ForecasController
        cityController = tabController.viewControllers![2] as! CityController
        
        dataCont = DataController()
        
        curController?.dataController = self.dataCont
        foreController?.dataController = self.dataCont
        cityController?.dataController = self.dataCont
        
        self.locationManager = CLLocationManager()
        
        curController?.locationManager = self.locationManager
        foreController?.locationManager = self.locationManager
        cityController?.locationManager = self.locationManager
        
        self.locationManager!.delegate = self
        locationManager!.requestAlwaysAuthorization()
        self.locationManager!.startUpdatingLocation()
        
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.locations = self.locationManager?.location?.coordinate
        self.location = CLLocation(latitude: (self.locations?.latitude)!, longitude: (self.locations?.longitude)!)
        geoCod.reverseGeocodeLocation(location!, completionHandler: {(placemarks, error) -> Void in
            var place: CLPlacemark!
            place = placemarks?[0]
            //print("Asking new location")
            //print(place)
            self.placeMark = placemarks?[0]
            self.curController?.setLocation(loc: self.locations!, place: place)
            self.foreController?.setLocation(loc: self.locations!)
        })
        
        self.locationManager!.stopUpdatingLocation()
    }
    
    func getNewLocation(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
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

