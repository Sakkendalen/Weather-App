//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit
import CoreLocation

class ForecasController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var stuff : [FiveDayWeatherModel] = []
    var fiveDayWeatherArray: FiveDayWeatherModel?
    
    var dataController : DataController?
    var geoCoder = CLGeocoder()
    var location : CLLocationCoordinate2D?
    var locationManager : CLLocationManager?

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.dataSource = self
        self.table.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        
        UserDefaults.standard.set(stuff, forKey: "forecastArray")
        UserDefaults.standard.synchronize()
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        
        if let defList = UserDefaults.standard.object(forKey: "forecastArray"){
            stuff = defList as! [FiveDayWeatherModel]
            table.reloadData()
        }
        
        super.decodeRestorableState(with: coder)
    }
    
    func setLocation(loc : CLLocationCoordinate2D){
        
        self.location = loc
        
        dataController!.fetchForecast(url: "https://api.openweathermap.org/data/2.5/forecast?lat=\(loc.latitude)&lon=\(loc.longitude)&cnt=40&units=metric&APPID=dc5b74f20581fd613891997b305fcfd2",cont: self)
    }
    
    func changeLocation(command: String){
        if(command == "Use GPS") {
            
            //locationManager?.startUpdatingLocation()
        }
        else {
            let str = command
            let replaced = str.replacingOccurrences(of: " ", with: "+")
            dataController!.fetchForecast(url: "https://api.openweathermap.org/data/2.5/forecast?q=\(replaced)&cnt=40&units=metric&APPID=dc5b74f20581fd613891997b305fcfd2",cont: self)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.fiveDayWeatherArray?.list.count {

            return count
        }
        else {

            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myProtoCell", for: indexPath) as! ForecastCell
        
        //weather i.e rain
        if let txt = self.fiveDayWeatherArray?.list[indexPath.row].weather[0].main {
            cell.weatherLabel.text = txt
        }
        //temperature
        if let txt = self.fiveDayWeatherArray?.list[indexPath.row].main.temp {
            let txt2 = String(format: "%.1f", txt)
            cell.weatherLabel.text = (cell.weatherLabel.text!) + "  \(txt2) °C"
        }
        //icon
        if let txt = self.fiveDayWeatherArray?.list[indexPath.row].weather[0].icon {
            cell.getImage(imgCode: txt)
        }
        //date
        if let txt = self.fiveDayWeatherArray?.list[indexPath.row].dt_txt {
            let now = txt
            cell.dateLabel.text = now
        }
        
        return cell
    }

}
