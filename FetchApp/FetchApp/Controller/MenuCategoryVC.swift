//
//  MenuCategoryVC.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import UIKit
import Networking

class MenuCategoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var menuCategoryViewModels = [MenuCategoryViewModel]()
    var selectedMenuCategoryId: String?
    
    // MARK:
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        initializeProperties()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MenuCategoryItemsVC {
            dest.menuCategoryId = selectedMenuCategoryId
        }
    }

    
    // MARK: - METHODS
    // ===================================================================================
    func initializeProperties() {
        setupNavBar()
        setupTableView()
        fetchData()
    }
    
    func setupNavBar() {
        navigationItem.title = "Menu Categories"
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    func fetchData() {
        RestApiServices(success: { (json) in
            let dict = json.dictionary
            if let data = dict["data"] as? NSArray {
                
                // Filter result that only have image url value
                self.menuCategoryViewModels = data.map({MenuCategoryViewModel.init(json: $0 as! [String : Any])}).filter({$0.imageUri.count > 0})
                
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }) { (error, statusCode) in
            print(error)
            
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }.getMenuCategories()
    }
    
    
    // MARK: - EVENTS
    // ===================================================================================
    

}


// MARK: - UITableView Delegate and DataSource
// ===================================================================================
extension MenuCategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCategoryViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuCategoryCell
        
        let viewModel = menuCategoryViewModels[indexPath.row]
        cell.viewModel = viewModel
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.init(red: 0.894, green: 0.945, blue: 0.957, alpha: 1.00)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = menuCategoryViewModels[indexPath.row]
        selectedMenuCategoryId = viewModel.id
        
        performSegue(withIdentifier: "goToMenuCategoryItemsVC", sender: self)
    }
}
