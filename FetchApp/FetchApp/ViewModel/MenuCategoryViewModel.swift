//
//  MenuCategoryViewModel.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import Foundation

class MenuCategoryViewModel {
    
    let id: String
    let name: String
    let imageUri: String
    
    init(json: [String: Any]) {
        let model = MenuCategoryModel(json: json)
        
        id = model.id ?? ""
        name = model.attributes?.name ?? ""
        imageUri = model.attributes?.imageUri ?? ""
    }
}
