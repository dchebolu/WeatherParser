//
//  UrlParamString.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

enum UrlParamString {
    case gps, search
}

/* This API needs custom handling like concatenating of params and hence this enum  */
extension UrlParamString {
    func getParameterStringFor(params: [String]) -> Parameters {
        switch self {
        case .gps:
            let gpsString = "lattlong"
            return [gpsString: params.joined(separator: ",")]
        case .search:
            let searchString = "query"
            return [searchString: params.joined(separator: ",")]
        }
    }
}
