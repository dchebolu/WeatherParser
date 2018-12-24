//
//  LocationListInteractor.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* Interactor helps to keep view controller lightweight and unit testable */
final class LocationListInteractor {
    static func saveToUserdefaults(urlParameter: Parameters) {
        var searchHistory: SearchHistory?
        if let latQuery = urlParameter["lattlong"] as? String {
            searchHistory = SearchHistory(query: latQuery, timeStamp: Date())
        } else if let textQuery = urlParameter["query"] as? String {
            searchHistory = SearchHistory(query: textQuery, timeStamp: Date())
        }
        
        if searchHistory != nil {
            PersistenceManager.sharedInstance.saveHistory(history: searchHistory!)
        }
    }
}
