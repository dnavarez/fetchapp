//
//  MenuCategoryItemModel.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import Foundation

class MenuCategoryItemModel: NSObject {
    var type: String?
    var id: String?
    var attributes: MenuCategoryItemAttribute?
    
    init(json: [String: Any]) {
        type = json["type"] as? String
        id = json["id"] as? String
        attributes = MenuCategoryItemAttribute.init(json: json["attributes"] as! [String : Any])
    }
}

class MenuCategoryItemAttribute: NSObject {
    var name: String?
    var desc: String?
    var imageUri: String?
    var price: Double?
    
    init(json: [String: Any]) {
        name = json["name"] as? String
        desc = json["description"] as? String
        imageUri = json["image-uri"] as? String
        price = json["price"] as? Double
    }
}
