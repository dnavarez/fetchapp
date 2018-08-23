//
//  MenuCategoryCell.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import UIKit
import AlamofireImage

class MenuCategoryCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: MenuCategoryViewModel! {
        didSet {
            titleLabel.text = viewModel.name
            
            if viewModel.imageUri.count > 0 {
                imgView.af_setImage(withURL: URL(string: (viewModel.imageUri))!)
            }
        }
    }
}
