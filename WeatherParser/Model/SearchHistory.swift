//
//  SearchHistory.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

final class SearchHistory: NSObject, NSCoding {
    
    var queryString: String?
    var timeStamp: Date?

    init(query: String?, timeStamp: Date) {
        self.queryString = query
        self.timeStamp = timeStamp
    }
    
    func encode(with aCoder: NSCoder) {
        if queryString != nil {
            aCoder.encode(queryString, forKey: "queryString")
        }
        if timeStamp != nil {
            aCoder.encode(timeStamp, forKey: "timeStamp")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let query = aDecoder.decodeObject(forKey: "queryString") as? String {
            queryString = query
        }
        
        if let timeStampTemp = aDecoder.decodeObject(forKey: "timeStamp") as? Date {
            timeStamp = timeStampTemp
        }
    }
}
