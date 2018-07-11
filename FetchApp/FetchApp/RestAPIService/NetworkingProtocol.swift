//
//  NetworkingProtocol.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import Networking


protocol NetworkingProtocol {
    var success: ((JSON) -> Swift.Void)? { get }
    var failure: ((JSON, Int) -> Swift.Void)? { get }
}

extension NetworkingProtocol {
    
    func request(url: String,
                 method: Methods,
                 parameters: [String: Any]?,
                 success: ((JSON) -> Swift.Void)?,
                 failure: ((JSON, Int) -> Swift.Void)?) {
        
        let networking = Networking(baseURL: Settings.BASE_URL)
        networking.headerFields = Settings.NETWORK_HEADERS
        
        switch method {
        case .get:
            networking.get(url) { (result) in
                switch result {
                case .success(let response):
                    success?(response.json)
                case .failure(let response):
                    failure?(response.json, response.statusCode)
                }
            }
        case .post:
            networking.post(url, parameterType: .json, parameters: parameters) { (result) in
                switch result {
                case .success(let response):
                    success?(response.json)
                case .failure(let response):
                    failure?(response.json, response.statusCode)
                }
            }
        }
    }
}
