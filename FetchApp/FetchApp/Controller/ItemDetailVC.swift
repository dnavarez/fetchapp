//
//  ItemDetailVC.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import UIKit

class ItemDetailVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: MenuCategoryItemsViewModel?
    
    
    // MARK:
    // ===================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeProperties()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.imageTransition != nil {
            UIView.animate(withDuration: 0.3) {
                appDelegate.imageTransition?.frame = self.imageView.frame
                self.view.layoutIfNeeded()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.imageView.isHidden = false
                appDelegate.imageTransition?.removeFromSuperview()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - METHODS
    // ===================================================================================
    func initializeProperties() {
        setupNavBar()
        
        imageView.isHidden = true
        titleLabel.text = "\(viewModel?.name ?? "")\n\(viewModel?.price ?? 0)"
        imageView.af_setImage(withURL: URL(string: (viewModel?.imageUri)!)!)
    }
    
    func setupNavBar() {
        navigationItem.title = "Item Detail"
    }
    
    
    // MARK: - EVENTS
    // ===================================================================================

}
