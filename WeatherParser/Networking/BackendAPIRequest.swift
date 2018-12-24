//
//  BackendAPIRequest.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* Even though this app needs only httpMethod GET, just including the other httpMethods as well*/
public enum Method: String {
    case get, post, put, delete
}

public typealias Parameters = [String: Any]

/* Even though this app needs only few request menthods, just including the other parameters as well*/
public protocol BackendAPIRequest {
    var endpoint: String { get }
    var method: Method { get }
    var urlParameter: Parameters? { get  set }
    var body: [String: Any]? { get set }
    var rawBody: Data? { get set}
}
