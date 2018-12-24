//
//  LocationListGETRequest.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

struct LocationListGETRequest: BackendAPIRequest {
    // Conforming to protocol
    var urlParameter: Parameters?
    
    var body: [String : Any]?
    
    var rawBody: Data?
    
    var endpoint: String {
        return "/location/search/"
    }
    
    var method: Method {
        return .get
    }
}
