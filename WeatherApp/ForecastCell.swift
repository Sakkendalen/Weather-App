//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 15/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit

class ForecastCell : UITableViewCell {
    

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var imageCodeForAPI:String = ""
    
    func getImage(imgCode: String) {
        
        imageCodeForAPI = imgCode
        
        if (UserDefaults.standard.data(forKey: imgCode) != nil) {
            //load from userDefaults
            print("should load from userdef")
            let img = UserDefaults.standard.data(forKey: imgCode)
            let img2 = UIImage(data: img!)
            self.cellImage.image = img2
        }
        else {
            print("fetch from internets")
            fetchImage(imgcode: imgCode)
        }
    }
    
    
    func fetchImage(imgcode: String) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url: URL? = URL(string: "https://openweathermap.org/img/wn/\(imgcode).png")
        let task = session.dataTask(with: url!, completionHandler: doneFetchingImage)
        task.resume()
    }
    
    //FETCHED IMAGE FROM API AND SAVED TO USERDEFAULTS
    func doneFetchingImage(data: Data?, response: URLResponse?, error: Error?) {
        DispatchQueue.main.async(execute: {() in
            
            let def = UserDefaults.standard   //UserDefaults kokeilu
            def.set(data, forKey: self.imageCodeForAPI)
            def.synchronize()
            
            let img = UIImage(data: data!)
            self.cellImage.image = img
        })
    }
    
}
