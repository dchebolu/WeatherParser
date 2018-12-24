//
//  ParameterEncoding.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* This can be enhanced to include body for POST requests. But keeping this specfic for this usecase */
enum ParameterEncoding {
    case url
}

extension ParameterEncoding {
    func encodeRequest(_ urlRequest: URLRequest, parameters: [String: Any]?) -> URLRequest {
        // return itself if no parameters
        if parameters == nil {
            return urlRequest
        }
        
        // copy the request so we can update it
        guard let mutableURLRequest = (urlRequest as NSURLRequest).mutableCopy() as? NSMutableURLRequest else {
            return urlRequest
        }
        switch self {
        case .url:
            var urlQueryItems: [URLQueryItem] = []
            
            parameters?.forEach { (key, value) in
                let queryParam = URLQueryItem(name: key, value: (value as? String) ?? "")
                urlQueryItems.append(queryParam)
            }
            
            if var URLComponents = URLComponents(url: mutableURLRequest.url!, resolvingAgainstBaseURL: false) {
                URLComponents.queryItems = urlQueryItems
                mutableURLRequest.url = URLComponents.url
            }
        }
        return mutableURLRequest as URLRequest
    }
}

