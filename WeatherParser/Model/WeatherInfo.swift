//
//  WeatherInfo.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* Model to parse weather info from  API request. Only attributes needed for this app were included in this model. If required the model can always be enhanced to include other attributes */
struct WeatherInfo: Codable {
    /* I don't have info what are the required attributes and as well UX design. Usually this input comes from functional team mentioning the required attributes and api team needs to adhere to that. Hence all of them are non-optional */
    var id: Int
    var weatherState: String
    var humidity: Int
    
    /* Need enum coding keys to customize attribute names */
    enum CodingKeys: String, CodingKey {
        case id
        case weatherState = "weather_state_name"
        case humidity
    }
}

extension WeatherInfo {
    func getState() -> String {
        return "weatherState:\(weatherState)"
    }
    
    func getHumidity() -> String {
        return "humidity:\(humidity)"
    }
}
