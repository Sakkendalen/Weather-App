//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saku Tynjälä on 08/10/2019.
//  Copyright © 2019 Saku Tynjälä. All rights reserved.
//

import UIKit
import CoreLocation

class CityController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var cityTextField: UITextField!
    var stuff = ["Use GPS"]

    @IBOutlet weak var table: UITableView!
    var selectedCity : Int?
    
    var dataController : DataController?
    var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.dataSource = self
        self.table.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        
        //save array to userdefaults
        UserDefaults.standard.set(stuff, forKey: "myStuff")
        
        //save cityTextField
        if let text = self.cityTextField.text {
            coder.encode(text, forKey: "cityInput")
        }
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        
        //fetch and check array from userdefaults and assign them to stuff Array
        if let defList = UserDefaults.standard.stringArray(forKey: "myStuff"){
            stuff = defList
            table.reloadData()
        }
        
        //fetch inputfield and put string to cityTextField
        if let input = coder.decodeObject(forKey: "cityInput"){
            self.cityTextField.text = input as? String
        }
        
        super.decodeRestorableState(with: coder)
    }
    
    @IBAction func addCity(_ sender: Any) {
        if let text = cityTextField.text{
            if text != nil &&
                text != "" &&
                text.trimmingCharacters(in: .whitespaces).count != 0 {
                print(text)
                if !stuff.contains(cityTextField.text!){
                    self.stuff.append(cityTextField.text!)
                    table.reloadData()
                    cityTextField.text = ""
                }
            }
        }
    }
    
    @IBAction func removeCity(_ sender: Any) {
        if selectedCity != nil{
            if selectedCity != 0 {
                stuff.remove(at: selectedCity!)
                table.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = indexPath.row
        dataController?.locationChanged(command: "\(stuff[indexPath.row])")
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
