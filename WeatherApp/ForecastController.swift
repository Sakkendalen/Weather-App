//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit

class ForecasController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var stuff : [FiveDayWeatherModel] = []
    var fiveDayWeatherArray: FiveDayWeatherModel?

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.dataSource = self
        self.table.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        
        UserDefaults.standard.set(stuff, forKey: "forecastArray")
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        
        if let defList = UserDefaults.standard.object(forKey: "forecastArray"){
            stuff = defList as! [FiveDayWeatherModel]
        }
        
        super.decodeRestorableState(with: coder)
    }
 
    
    func passData(model: FiveDayWeatherModel){
        fiveDayWeatherArray = model
        //print(stuff)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //NSLog("\(stuff[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.fiveDayWeatherArray?.list.count {
            //print("COUNT")
            return count
        }
        else {
            //print("array empty")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let df = DateFormatter()
        
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
        if let txt = self.fiveDayWeatherArray?.list[indexPath.row].dt {
            df.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let now = df.string(from: txt)
            cell.dateLabel.text = now
        }
        
        return cell
    }

}
