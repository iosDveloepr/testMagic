//
//  Weater.swift
//  test
//
//  Created by Anton Yermakov on 30.05.2018.
//  Copyright © 2018 Anton Yermakov. All rights reserved.
//

import Foundation

struct Weather {
    
    var description : String
    var temp : Double
    var humidity : Int
    var temp_min : Double
    var temp_max : Double
    var name : String
    var unixDT : Double
    var icon : String
    
    enum SerializationError : Error {
        case missing(String)
    }
    
    init (json: [String: Any]) throws {
        
          guard let main = json["main"] as? [String: Any] else { throw SerializationError.missing("The main is missing")}
          guard let humidity = main["humidity"] as? Int else { throw SerializationError.missing("The humidity is missing")}
          guard let temp = main["temp"] as? Double else { throw SerializationError.missing("The temperature is missing")}
          guard let temp_min = main["temp_min"] as? Double else { throw SerializationError.missing("The temp_min is missing")}
          guard let temp_max = main["temp_max"] as? Double else { throw SerializationError.missing("The temp_max is missing")}
        
          guard let name = json["name"] as? String else { throw SerializationError.missing("The name is missing")}
          guard let weather = json["weather"] as? [[String : Any]] else { throw SerializationError.missing("The name is missing")}
          guard let weatherDescription = weather.first?["description"] as? String else { throw SerializationError.missing("The description is missing")}
        guard let weatherIcon = weather.first?["icon"] as? String else { throw SerializationError.missing("The icon is missing")}
        
          guard let unixDt = json["dt"] as? Double else { throw SerializationError.missing("The unix time is missing")}
        

        self.description = weatherDescription
        self.temp = temp
        self.humidity = humidity
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.name = name
        self.unixDT = unixDt
        self.icon = weatherIcon
        
    }
} // class
