//
//  LocationWeatherDetailNetworkManager.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/*This is place where if needed the data will be handed of to coredata layer as well. */
final class LocationWeatherDetailNetworkManager {
    let locationListService: BackendService
    
    init(backEndService: BackendService) {
        locationListService = backEndService
    }
    
    func getListOfWeatherInfoWith(request: BackendAPIRequest, completionHandler:@escaping (([WeatherInfo]?, ErrorType?) -> Void)) {
        locationListService.request(request) { (data, httpResponse, error) in
            guard error == nil, let data = data else {
                completionHandler(nil, .internalError())
                return
            }
            if let networkResponse = try? JSONDecoder().decode(WeatherInfoAPIResponse.self, from: data) {
                // success
                completionHandler(networkResponse.consolidated_weather, nil)
            } else if let responseString = String(data: data, encoding: .utf8), httpResponse?.statusCode != 200 {
                //Server error message
                completionHandler(nil, .serverError(responseString))
            } else {
                completionHandler(nil, .serverError("Something Unexpected Happened."))
            }
        }
    }
}
