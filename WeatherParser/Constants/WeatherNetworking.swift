//
//  WeatherNetworking.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/* Keeping only 2 error types one for server and one for client side */
enum ErrorType {
    case serverError(String?)
    case internalError()
    
    func getAlertMessage() -> String {
        switch self {
        case .serverError(let message):
            return message ?? ""
        case .internalError():
            return "Something UnExpected Happened."
        }
    }
}

/** Constants struct for networking */
struct WeatherNetworking {
    /* In this coding challenge case all the url requests hit the same domain. Hence declaring configuartion it as static */
    static let configuration = BackendConfiguration(baseURL: weatherAPIURL())

    /* We don't have environments in this example, but this is where those constants would live. */
    private struct Domain {
        private static let dev = "www.metaweather.com"
        private static let qa = "www.metaweather.com"
        private static let uat = "www.metaweather.com"
        private static let prod = "www.metaweather.com"
        
        /* Hardcoding this for now, but this value would be accessed from the scheme the app is built with. */
        static func currentEnvironment() -> String {
            return dev
        }
    }
    
    /* This is where environment specific or different routes for the API would live. */
    private struct Route {
        static let api = "/api"
    }
        
    static func weatherAPIURL() -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = Domain.currentEnvironment()
        urlComponents.path = Route.api
        
        guard let url = urlComponents.url else {
            /* Should crash if this can't construct so it is clear where this happens since the app relies on this to function. */
            fatalError("Could not construct URL for passes endpoint.")
        }
        
        return url
    }
}
