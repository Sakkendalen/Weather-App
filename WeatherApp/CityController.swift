//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit

class CityController: UIViewController {
    
    var dataController : DataController!
    @IBOutlet weak var asd3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.asd3.text = "Testi 3 onnistunut"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}
