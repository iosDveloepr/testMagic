//
//  NewtworkProcessor.swift
//  test
//
//  Created by Anton Yermakov on 30.05.2018.
//  Copyright © 2018 Anton Yermakov. All rights reserved.
//

import Foundation
import Alamofire

typealias ErrorHandler = (_ msg: String?) -> Void

class NetworkProcessor{
    
    private init() {}
    static let sharedInstance = NetworkProcessor()
    
    func dowbloadJson(fromCity citys: [String], completion: @escaping ([Weather]) -> (), errorHandling: ErrorHandler?) {
        
        for city in citys {
        
            let url = "http://api.openweathermap.org/data/2.5/weather?q=\(city.replacingOccurrences(of: " ", with: "%20"))&units=metric&appid=d3c27fee4205d507a83f8bc1b73640c3"
            
            let urlRequest = URLRequest(url: URL(string: url)!)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                    errorHandling?(error?.localizedDescription)
                } else {
                    errorHandling?(nil)
                }
                
                guard let data = data else { return }
                var weatherArray : [Weather] = []
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                        
                        
                        if let weatherObject = try? Weather(json: json) {
                            print(weatherObject)
                            weatherArray.append(weatherObject)
                        }
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
                
                completion(weatherArray)
            }
            task.resume()
        }
    }
    
    
    func dowbloadForecastJson(fromCity city: String, completion: @escaping ([WeatherForecast]) -> (), errorHandling: ErrorHandler?) {

            let url = "http://api.openweathermap.org/data/2.5/forecast?q=\(city.replacingOccurrences(of: " ", with: "%20"))&units=metric&appid=d3c27fee4205d507a83f8bc1b73640c3"
            let urlRequest = URLRequest(url: URL(string: url)!)

            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

                if error != nil {
                    print(error!.localizedDescription)
                    errorHandling?(error?.localizedDescription)
                } else {
                    errorHandling?(nil)
                }

                guard let data = data else { return }
                var forecastArray : [WeatherForecast] = []

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                        if let list = json["list"] as? [[String : Any]]{
                            for weatherData in list {
                                if let weatherObject = try? WeatherForecast(json: weatherData) {
                                    print(weatherObject)
                                    forecastArray.append(weatherObject)
                                }
                            }
                        }
                    }
                }
                catch {
                    print(error.localizedDescription)
                }

                completion(forecastArray)
            }
            task.resume()
      }


    
    
    

    
} // class




