//
//  LocationListNetworkManager.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation

/*This is place where if needed the data will be handed off to coredata layer as well. */
final class LocationListNetworkManager {
    let locationListService: BackendService
    
    init(backEndService: BackendService) {
        locationListService = backEndService
    }
    
    func getListOfLocationsWith(request: BackendAPIRequest, completionHandler:@escaping (([Location]?, ErrorType?) -> Void)) {
        locationListService.request(request) { (data, httpResponse, error) in
            guard error == nil, let data = data else {
                completionHandler(nil, .internalError())
                return
            }
            if let networkResponse = try? JSONDecoder().decode(Array<Location>.self, from: data) {
                /* Handoff to to interactor to Presently store all the search keyworks/location with a time stamp so that when the
                user can see search history in the future */
                if let params = request.urlParameter {
                    LocationListInteractor.saveToUserdefaults(urlParameter: params)
                }
                print("*********PersistedSearchHistoryCount\(String(describing: PersistenceManager.sharedInstance.getAllSavedHistory()?.count))")
                // success
                completionHandler(networkResponse, nil)
            } else if let responseString = String(data: data, encoding: .utf8), httpResponse?.statusCode != 200 {
                //Server error message
                completionHandler(nil, .serverError(responseString))
            } else {
                completionHandler(nil, .serverError("Something Unexpected Happened."))
            }
        }
    }
}
