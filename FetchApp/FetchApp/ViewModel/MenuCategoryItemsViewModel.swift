//
//  MenuCategoryItemsViewModel.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import Foundation

class MenuCategoryItemsViewModel {
    
    let id: String
    let name: String
    let imageUri: String
    let price: Double
    
    init(json: [String: Any]) {
        let model = MenuCategoryItemModel(json: json)
        
        id = model.id ?? ""
        name = model.attributes?.name ?? ""
        imageUri = model.attributes?.imageUri ?? ""
        price = model.attributes?.price ?? 0
    }
}
