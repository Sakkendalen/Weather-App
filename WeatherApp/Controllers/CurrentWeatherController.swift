//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentWeatherController: UIViewController {
    
    var dataController : DataController?
    
    var geoCoder = CLGeocoder()
    var location : CLLocationCoordinate2D?
    
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {

    }
    
    /*
    override func encodeRestorableState(with coder: NSCoder) {
        
        coder.encode(self.place.text, forKey: "placeName")
        coder.encode(self.temperature.text, forKey: "temp")
        coder.encode(self.desc.text, forKey: "description")
        coder.encode(self.image.image, forKey: "weatherImage")
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        
        let place = coder.decodeObject(forKey: "placeName") as? String
        let temp = coder.decodeObject(forKey: "temp") as? String
        let desc = coder.decodeObject(forKey: "description") as? String
        let img = coder.decodeObject(forKey: "weatherImage") as? UIImage
        
        if let text = place,
            let text2 = temp,
            let text3 = desc,
            let weathImg = img{
            self.place.text = text
            self.temperature.text = text2
            self.desc.text = text3
            self.image.image = weathImg
        }
        super.decodeRestorableState(with: coder)
    }
    */

    func setLocation(loc : CLLocationCoordinate2D, place : CLPlacemark){
        self.location = loc
        self.place.text = place.locality!
        dataController!.fetchWeather(url: "https://api.openweathermap.org/data/2.5/weather?lat=\(loc.latitude)&lon=\(loc.longitude)&units=metric&APPID=dc5b74f20581fd613891997b305fcfd2",cont: self)
        //print(place.locality)
        print(loc)
        //print(place)
    }
    
    func changeLocation(command: String){
        if(command == "Use GPS") {
            let locTest = CLLocation(latitude: self.location!.latitude, longitude: self.location!.longitude)
            
            geoCoder.reverseGeocodeLocation(locTest, completionHandler: { (placemarks, error) -> Void in
                

                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                
                //print(placeMark.addressDictionary as Any)
                self.place.text = placeMark.locality!
            })
            
            dataController!.fetchWeather(url: "https://api.openweathermap.org/data/2.5/weather?lat=\(location!.latitude)&lon=\(location!.longitude)&units=metric&APPID=dc5b74f20581fd613891997b305fcfd2",cont: self)
            
        }
        else {
            let str = command
            let replaced = str.replacingOccurrences(of: " ", with: "+")
            self.place.text = command
            dataController!.fetchWeather(url: "https://api.openweathermap.org/data/2.5/weather?q=\(replaced)&units=metric&APPID=dc5b74f20581fd613891997b305fcfd2",cont: self)
        }
    }
    
}
