//
//  RestAPIServices.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import Networking

enum Methods {
    case get, post
}

struct Settings {
    static var BASE_URL = "https://api.solo.skylinedynamics.com/"
    static var NETWORK_HEADERS = ["Content-Type":"application/json", "Solo-Concept":"8", "Accept-Language":"en-us"]
}

struct RestApiServices: NetworkingProtocol {
    
    internal var success: ((JSON) -> Swift.Void)?
    internal var failure: ((JSON, Int) -> Swift.Void)?
    
    func getMenuCategories() {
        request(url: "menus/10/categories",
                method: .get,
                parameters: nil,
                success: success,
                failure: failure)
    }
    
    func getMenuCategoryItems(categoryId: String) {
        request(url: "menus/10/categories/\(categoryId)/items",
                method: .get,
                parameters: nil,
                success: success,
                failure: failure)
    }
}
