//
//  DetailCityWeatherVC.swift
//  test
//
//  Created by Anton Yermakov on 31.05.2018.
//  Copyright © 2018 Anton Yermakov. All rights reserved.
//

import UIKit

class DetailCityWeatherVC: UIViewController {
    
    var weather : Weather?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var min_tempLabel: UILabel!
    @IBOutlet weak var max_tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var city : String!

    override func viewDidLoad() {
        super.viewDidLoad()

       setupLabels()
       
    }
    
    private func setupLabels(){
        
         guard let name = weather?.name else { return }
         guard let description = weather?.description else { return }
         guard let humidity = weather?.humidity.description else { return }
         guard let temperature = weather?.temp.description else { return }
         guard let maxTemp = weather?.temp_max.description else { return }
         guard let minTemp = weather?.temp_min.description else { return }
         guard let dateFromUnix = weather?.unixDT.getDateStringFromUTC() else { return }
        
        
        cityLabel.text = name
        descriptionLabel.text = description
        humidityLabel.text = "\(humidity) humidity"
        temperatureLabel.text = "\(temperature) Cº"
        min_tempLabel.text = "\(minTemp) Cº min temp."
        max_tempLabel.text = "\(maxTemp) Cº max temp."
        dateLabel.text = dateFromUnix
        
        self.city = name
        
        
        guard let icon = weather?.icon else { return }
        let imageLink = "http://openweathermap.org/img/w/\(icon).png"
        weatherIcon.loadImageUsingCacheWithUrlString(imageLink)
        
    }

    
    @IBAction func ShowWeekForecast(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeekForecast") as! WeekForecastVC
        vc.city = city
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}







