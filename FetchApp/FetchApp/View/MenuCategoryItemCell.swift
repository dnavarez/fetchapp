//
//  MenuCategoryItemCell.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import UIKit

class MenuCategoryItemCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var viewModel: MenuCategoryItemsViewModel! {
        didSet {
            titleLabel.text = viewModel.name
            priceLabel.text = "\(viewModel.price)"
            
            imgView.af_setImage(withURL: URL(string: (viewModel.imageUri))!)
        }
    }

}
