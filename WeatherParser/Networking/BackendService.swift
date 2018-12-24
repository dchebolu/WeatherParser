//
//  BackendService.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* This protocol helps to mock Networking layer for unit tetsing purpose. */
protocol BackendService {
    func request(_ request: BackendAPIRequest, completionHandler:@escaping ((Data?, HTTPURLResponse?, Error?) -> Void))
    func cancel()
}

extension BackendService {
    /* This method should have ability to construct URLRequest based on BackendAPIRequest variables and can be more modular. However for the sake of this challenge I am keeping this method very simply and very specific to only one GET API */
    func createNSURlRequest(_ request: BackendAPIRequest, configuration: BackendConfiguration) -> URLRequest {
        let url = configuration.baseURL.appendingPathComponent(request.endpoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue(URLHeader.Value.json, forHTTPHeaderField: URLHeader.Key.contentType)
        
        let urlRequestWithURLParameters =
            ParameterEncoding.url.encodeRequest(urlRequest, parameters: request.urlParameter as [String : Any]?)
        
        print("NSURLRequest = \(urlRequestWithURLParameters)")
        return urlRequestWithURLParameters
    }
}
