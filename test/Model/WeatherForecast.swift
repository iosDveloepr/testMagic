//
//  WeatherForecast.swift
//  test
//
//  Created by Anton Yermakov on 31.05.2018.
//  Copyright © 2018 Anton Yermakov. All rights reserved.
//

import Foundation

struct WeatherForecast{
    
    var dt : Double
    var temperature : Double
    var description : String
    var icon : String
    
    enum SerializationError : Error {
        case missing(String)
    }
    
    init(json: [String : Any]) throws {
        
         guard let dateUnix = json["dt"] as? Double else { throw SerializationError.missing("The unix date is missing")}
         guard let main = json["main"] as? [String : Any] else { throw SerializationError.missing("The main is missing")}
         guard let temp = main["temp"] as? Double else { throw SerializationError.missing("The temperature is missing")}
         guard let weather = json["weather"] as? [[String : Any]] else { throw SerializationError.missing("The weather is missing")}
         guard let description = weather.first?["description"] as? String else { throw SerializationError.missing("The description is missing")}
        guard let icon = weather.first?["icon"] as? String else { throw SerializationError.missing("The icon is missing")}
        
        self.dt = dateUnix
        self.temperature = temp
        self.description = description
        self.icon = icon
     
    }
} // class
