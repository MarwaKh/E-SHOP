//
//  MainScreenVC.swift
//  E-SHOP
//
//  Created by My Computer on 2017-06-08.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit


class MainScreenVC: UIViewController {

    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var catalogCollectionView: UICollectionView!
    
    @IBOutlet weak var desiredItemsTableView: UITableView!
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var subTotal: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var items = [Item]()
    var indexOfItemSelected: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        titleLabel.text = "E-SHOP"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32.0)
        titleLabel.textColor = UIColor.white
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
//        spinner.startAnimating()
//       Item.retrieveItems { (items) in
//        self.items = items
//        self.catalogCollectionView.reloadData()
//        self.spinner.stopAnimating()
//        }

//        self.desiredItemsTableView.reloadData()
  
    }

    
    @IBAction func ProceedToCheckBtnTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil, message: "Are you sure you want to proceed to check out?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
        
        alert.addAction(yesAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.heightConstraint.constant = CGFloat(140 * WishlistManager.sharedInstance.wishList.count) + 140
        
        self.desiredItemsTableView.reloadData()
        
        totalPrice.text = "Total $\(WishlistManager.sharedInstance.totalPrice())"
        subTotal.text = "$\(WishlistManager.sharedInstance.totalPrice())"
        
        if let index = self.desiredItemsTableView.indexPathForSelectedRow {
            self.desiredItemsTableView.deselectRow(at: index, animated: true)
        }
     
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
        
        spinner.startAnimating()
        Item.retrieveItems { (items) in
            self.items = items
            self.catalogCollectionView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "From Catalogue" {
            if let destination = segue.destination as? ItemVC {
                if let itemDestination = sender as? Item {
                    destination.itemSelected = itemDestination
                    destination.hideRemoveBtn = true
                }
            }
        } else if segue.identifier == "From Wishlist" {
            if let destination = segue.destination as? ItemVC {
                if let itemDestination = sender as? Item {
                    destination.itemSelected = itemDestination
                    destination.itemIndex = indexOfItemSelected
                    destination.hideAddBtn = true
                }
            }
        }
    }
    
}


// MARK: - Implementation of UICollectionViewDelegate and UICollectionViewDataSource methods
    extension MainScreenVC : UICollectionViewDataSource, UICollectionViewDelegate {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
            return items.count
         
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = catalogCollectionView.dequeueReusableCell(withReuseIdentifier: "Product Cell", for: indexPath) as! ProductCollectionCell
            
            cell.item = self.items[indexPath.item]
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let item = items[indexPath.item]
            performSegue(withIdentifier: "From Catalogue", sender: item)
        }
}


// MARK: - Implementation of UITableViewDelegate and UITableViewDataSource methods
extension MainScreenVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if (WishlistManager.sharedInstance.wishList.count > 0) {
            self.desiredItemsTableView.backgroundView = nil
            return 1
        }
        
        let rect = CGRect(x: 0, y: 0, width: self.desiredItemsTableView.bounds.size.width, height: self.desiredItemsTableView.bounds.size.height)
        let noDataAdded: UILabel = UILabel(frame: rect)
        noDataAdded.text = "No data added to the wishlist"
        noDataAdded.textColor = UIColor.darkGray
        noDataAdded.textAlignment = NSTextAlignment.center
        self.desiredItemsTableView.backgroundView = noDataAdded
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return WishlistManager.sharedInstance.wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = desiredItemsTableView.dequeueReusableCell(withIdentifier: "itemChosenCell", for: indexPath) as! WishListCell
        
        cell.item = WishlistManager.sharedInstance.wishList[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = WishlistManager.sharedInstance.wishList[indexPath.row]
        indexOfItemSelected = indexPath.row
        performSegue(withIdentifier: "From Wishlist", sender: item)
    }
    
    
}

