//
//  URLHeader.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

struct URLHeader {
    /* For now I'm namespacing these by Key and Value. */
    struct Key {
        static let contentType = "Content-Type"
    }
    
    struct Value {
        static let json = "Application/json"
    }
}
