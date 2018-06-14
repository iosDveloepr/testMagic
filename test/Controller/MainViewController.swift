//
//  MainViewController.swift
//  test
//
//  Created by Anton Yermakov on 30.05.2018.
//  Copyright © 2018 Anton Yermakov. All rights reserved.
//

import UIKit
import CoreData


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var cityWeather = [Weather]()
    var cityToFind = ["Kiev", "Vinnytsia"]
    var cityDB = [Cities]()
    var managedObjectContext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadData()
        
        for cities in cityDB{
            if let city = cities.city{
                print(city)
                self.cityToFind.append(city)
            }
        }
        
        NetworkProcessor.sharedInstance.dowbloadJson(fromCity: cityToFind, completion: { (allCities) in
            
            for city in allCities{
                self.cityWeather.append(city)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }) {  (errorMessage) in
            if let error = errorMessage{
                Alert.alertError(withMessage: error, vc: self)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        let cityInfo = cityWeather[indexPath.row]
        
        cell.cityLabel.text = cityInfo.name
        cell.temperatureLabel.text = "\(cityInfo.temp) Cº"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as! DetailCityWeatherVC
        vc.weather = cityWeather[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        
        let cityItem = Cities(context: managedObjectContext)
        
        var alert = UIAlertController(title: "Add city", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "City"
        }
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action: UIAlertAction) in
            
            let city = alert.textFields?.first
            
            if let cityWeather = city?.text {
            
                NetworkProcessor.sharedInstance.dowbloadJson(fromCity: [cityWeather], completion: { (weatherInfo) in
                    
                    for cityInfo in weatherInfo{
                        self.cityWeather.append(cityInfo)
                        cityItem.city = cityInfo.name
                    }
                    
                    do{
                        try self.managedObjectContext.save()
                    } catch {
                        print (error.localizedDescription)
                    }
                    
                     DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }, errorHandling: {  (error) in
                    if let errorMessage = error {
                        Alert.alertError(withMessage: errorMessage, vc: self)
                    }
                })
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func loadData(){
        let request : NSFetchRequest<Cities> = Cities.fetchRequest()
        do {
            cityDB = try managedObjectContext.fetch(request)
            self.tableView.reloadData()
        } catch {
            print (error.localizedDescription)
        }
    }


} // class


    











