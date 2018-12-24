//
//  BackendConfiguration.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* This class is useful in cases where a app hits multiple domains. */
struct BackendConfiguration {
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
