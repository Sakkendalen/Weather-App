//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit

class CityController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var stuff = ["Use GPS", "Helsinki", "Tampere", "Turku"]

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.dataSource = self
        self.table.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(self.stuff, forKey: "stuff")
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        let weatherStuff = coder.decodeObject(forKey: "weathArray") as? Array<Any>
        
        //HOX HOX
        if let model = weatherStuff {
            self.stuff = model as! [String]
        }
        
        super.decodeRestorableState(with: coder)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //NSLog("\(stuff[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stuff.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "someID")
        
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "someID")
        }
        
        cell!.textLabel!.text = self.stuff[indexPath.row]
        
        return cell!
    }

}
