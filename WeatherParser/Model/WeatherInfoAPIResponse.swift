//
//  WeatherInfoAPIResponse.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/** Model to parse weather API response. These model creations are based on structure of API response.*/
struct WeatherInfoAPIResponse: Codable {
    var consolidated_weather: [WeatherInfo]
}
