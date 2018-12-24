//
//  LocationWeatherInfo.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

struct LocationWeatherGETRequest: BackendAPIRequest {
    var earthId: String
    init(earthId: String) {
        self.earthId = earthId
    }
    
    // Conforming to protocol
    var urlParameter: Parameters?
    
    var body: [String : Any]?
    
    var rawBody: Data?
    
    var endpoint: String {
        return "/location/\(earthId)"
    }
    
    var method: Method {
        return .get
    }
}
