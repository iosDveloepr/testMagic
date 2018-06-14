//
//  WeekForecastVC.swift
//  test
//
//  Created by Anton Yermakov on 31.05.2018.
//  Copyright © 2018 Anton Yermakov. All rights reserved.
//

import UIKit

class WeekForecastVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var city : String!
    var weatherForecast = [WeatherForecast]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkProcessor.sharedInstance.dowbloadForecastJson(fromCity: city, completion: { (weatherJson) in
            
            for weather in weatherJson{
                self.weatherForecast.append(weather)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (error) in
            if let errorMessage = error {
                Alert.alertError(withMessage: errorMessage, vc: self)
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekForecastCell", for: indexPath) as! WeekForecastTableViewCell
        
        let weather = weatherForecast[indexPath.row]
        
        cell.temperature.text = "\(weather.temperature) Cº"
        cell.date.text = weather.dt.getDateStringFromUTC()
        cell.desc.text = weather.description
        
        let imageLink = "http://openweathermap.org/img/w/\(weather.icon).png"
        cell.icon.loadImageUsingCacheWithUrlString(imageLink)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    


 

}
