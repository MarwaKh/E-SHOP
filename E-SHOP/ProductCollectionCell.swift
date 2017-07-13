//
//  ProductCollectionCell.swift
//  E-SHOP
//
//  Created by My Computer on 2017-06-09.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {
    
    var item: Item! {
        didSet {
            updateCell()
        }
        
    }
    @IBOutlet weak var itemPicture: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    private func updateCell() {
        
        itemPicture.image = UIImage(named: item.imagePath!)
        itemName.text = item.name
        
    }
    
}
