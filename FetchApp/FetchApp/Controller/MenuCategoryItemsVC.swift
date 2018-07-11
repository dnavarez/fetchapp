//
//  MenuCategoryItemsVC.swift
//  FetchApp
//
//  Created by klooma developer on 11/07/2018.
//  Copyright © 2018 Dan Navarez. All rights reserved.
//

import UIKit

class MenuCategoryItemsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var menuCategoryItemsViewModel = [MenuCategoryItemsViewModel]()
    var menuCategoryId: String?
    var selectedViewModel: MenuCategoryItemsViewModel?
    
    
    // MARK:
    // ===================================================================================
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
        if let dest = segue.destination as? ItemDetailVC {
            dest.viewModel = selectedViewModel
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
        navigationItem.title = "Menu Category Items"
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    func fetchData() {
        RestApiServices(success: { (json) in
            guard let data = json.dictionary["data"] as? NSArray else { return }
            
            self.menuCategoryItemsViewModel = data.map({MenuCategoryItemsViewModel.init(json: $0 as! [String : Any])})
            
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }) { (error, statusCode) in
            print(error)
            
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            }.getMenuCategoryItems(categoryId: menuCategoryId!)
    }
    
    
    // MARK: - EVENTS
    // ===================================================================================
    
    
}


// MARK: - UITableView Delegate and DataSource
// =======================================================================================
extension MenuCategoryItemsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCategoryItemsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuCategoryItemCell
        
        let viewModel = menuCategoryItemsViewModel[indexPath.row]
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
        let viewModel = menuCategoryItemsViewModel[indexPath.row]
        selectedViewModel = viewModel
        
        let cell = tableView.cellForRow(at: indexPath) as! MenuCategoryItemCell
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            DispatchQueue.main.async {
                if cell.imgView.image != nil {
                    let frame = cell.convert(cell.imgView.frame, to: self.view)
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let window = UIApplication.shared.keyWindow
                    
                    appDelegate.imageTransition = UIImageView.init(image: cell.imgView.image)
                    appDelegate.imageTransition?.frame = frame
                    appDelegate.imageTransition?.contentMode = .scaleAspectFit
                    window?.addSubview(appDelegate.imageTransition!)
                }
            }
        }
        
        performSegue(withIdentifier: "goToItemDetailPage", sender: self)
    }
}
