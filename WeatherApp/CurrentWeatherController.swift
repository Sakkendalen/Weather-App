//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit

class CurrentWeatherController: UIViewController {
    
    var dataController : DataController!
    @IBOutlet weak var asda: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.asda.text = "Testi 1 onnistunut"
        // Do any additional setup after loading the view, typically from a nib.
    }
}
