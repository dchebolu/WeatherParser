//
//  SessionManager.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation
/* Networking components can go deep beyond this. However for this challenge I keeping it simply just to handle data tasks */
final class SessionManager: BackendService {
    
    private var task: URLSessionDataTask?
    private let conf: BackendConfiguration
    
    init(_ conf: BackendConfiguration) {
        self.conf = conf
    }
    
    func request(_ request: BackendAPIRequest, completionHandler: @escaping ((Data?, HTTPURLResponse?, Error?) -> Void)) {
        let urlRequest = createNSURlRequest(request, configuration: conf)
        task = URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            completionHandler(data, response as? HTTPURLResponse, error)
        })
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
