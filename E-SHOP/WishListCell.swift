//
//  WishListCell.swift
//  E-SHOP
//
//  Created by My Computer on 2017-06-10.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class WishListCell: UITableViewCell {
    
    var itemColors: [String]?
    
    var item: Item! {
        didSet {
            updateCell()
        }
        
    }
    
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    
    @IBOutlet weak var productColorCollectionView: UICollectionView! {
        didSet {
            productColorCollectionView.delegate = self
            productColorCollectionView.dataSource = self
        }
    }
    
    
    private func updateCell() {
        
        productImg.image = UIImage(named: item.imagePath!)
        productPrice.text = "$\(item.price!)"
        productName.text = item.name
        productDescription.text = item.about
        itemColors = item?.getColors(item: item!)
        
    }
    
    
}

extension WishListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if (item.quantity != "0") {
            self.productColorCollectionView.backgroundView = nil
            return 1
        }
        
        //If the item selected is out of stock => Background shows uilabel out of stock
        let rect = CGRect(x: 0, y: 0, width: self.productColorCollectionView.bounds.size.width, height: self.productColorCollectionView.bounds.size.width)
        let outOfStockLabel: UILabel = UILabel(frame: rect)
        outOfStockLabel.text = "Out of stock"
        outOfStockLabel.textColor = UIColor.red
        outOfStockLabel.textAlignment = NSTextAlignment.left
        self.productColorCollectionView.backgroundView = outOfStockLabel
        
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (item?.quantity != "0") {
            
            return (itemColors?.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productColorCollectionView.dequeueReusableCell(withReuseIdentifier: "WishListColorCell", for: indexPath)
        
        cell.backgroundColor = UIColor(hexString: (self.itemColors?[indexPath.item])!)
        
        return cell
    }
}

