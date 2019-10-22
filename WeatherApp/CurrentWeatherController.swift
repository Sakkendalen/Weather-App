//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit

class CurrentWeatherController: UIViewController {
    
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
    
    override func encodeRestorableState(with coder: NSCoder) {
        
        print("Decode Current")
        
        coder.encode(self.place.text, forKey: "placeName")
        coder.encode(self.temperature.text, forKey: "temp")
        coder.encode(self.desc.text, forKey: "description")
        coder.encode(self.image.image, forKey: "weatherImage")
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        
        print("Decode Current")
        
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
    
    func takeData(model: WeatherDataModel){
        self.place.text = model.name
        self.desc.text = model.weather[0].description
        let formatted = String(format: "%.1f", model.main.temp)
        self.temperature.text = "  \(formatted) °C"
    }
    
    func takeImage(image: UIImage){
        self.image.image = image
    }
    
}
