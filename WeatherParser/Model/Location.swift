//
//  Location.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* Model to parse weather location from location API request. Only attributes needed for this app were included in this model. If required the model can always be enhanced to include other attributes */
struct Location: Codable {
    /* I don't have info what are the required attributes. Usually this input comes from functional team mentioning the required attributes and api team needs to adhere to that. Hence all of them are non-optional */
    var id: Int
    var title: String
    var type: String
    
    /* Need enum coding keys to customize attribute names */
    enum CodingKeys: String, CodingKey {
        case id = "woeid"
        case title
        case type = "location_type"
    }
}

extension Location {
    func getLocationId() -> String {
        return "id: \(id)"
    }
    
    func getLocationTitle() -> String {
        return "title: \(title)"
    }
    
    func getLocationType() -> String {
        return "LocationType: \(type)"
    }
}
