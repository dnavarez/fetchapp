//
//  MenuCategoryModel.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import Foundation

class MenuCategoryModel: NSObject {
    var type: String?
    var id: String?
    var attributes: MenuCategoryAttribute?
    
    init(json: [String: Any]) {
        type = json["type"] as? String
        id = json["id"] as? String
        attributes = MenuCategoryAttribute.init(json: json["attributes"] as! [String : Any])
    }
}

class MenuCategoryAttribute: NSObject {
    var name: String?
    var desc: String?
    var imageUri: String?
    
    init(json: [String: Any]) {
        name = json["name"] as? String
        desc = json["description"] as? String
        imageUri = json["image-uri"] as? String
    }
}

