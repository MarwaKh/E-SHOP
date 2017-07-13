//
//  ItemVC.swift
//  E-SHOP
//
//  Created by My Computer on 2017-06-09.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class ItemVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var itemImg: UIImageView!
    
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var itemDescription: UILabel!
    
    @IBOutlet weak var itemSize: UILabel!
    
    @IBOutlet weak var itemSize2: UILabel!
    
    @IBOutlet weak var itemSize3: UILabel!
    
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet weak var priceView: UIView!
    
    @IBOutlet weak var sizeView: UIView!
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var removeBtn: UIButton!
    
    var itemSelected: Item?
    var itemIndex: Int?
    var itemSizes: [String]?
    var hideRemoveBtn: Bool = false
    var hideAddBtn: Bool = false
    
    var itemColors: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+10)
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        //add a grey border to the view
        priceView.layer.borderWidth = 0.25
        priceView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        
        
        if (hideRemoveBtn) {
            removeBtn.isHidden = true
            removeBtn.isEnabled = true
        }
        
        if (hideAddBtn) {
            addBtn.isHidden = true
            addBtn.isEnabled = true
        }
        
        itemColors = itemSelected?.getColors(item: itemSelected!)
        itemSizes = itemSelected?.getSize(item: itemSelected!)
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = itemSelected?.name
        
        print(itemSelected)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sizeView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 4.0)
    }
    
    @IBAction func addBtnTapped(_ sender: UIButton) {
        print("______________________")
        WishlistManager.sharedInstance.addItem(item: itemSelected!)
        print("______________________")
        //        print(WishlistManager.sharedInstance.totalPrice())
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func removeBtnTapped(_ sender: UIButton) {
        
        WishlistManager.sharedInstance.removeItem(index: itemIndex!)
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    //retrieve all the information about the selected item
    func loadData() {
        
        if let item = itemSelected {
            itemPrice.text = "$\(item.price!)"
            itemDescription.text = item.desc
            itemSize.text = itemSizes?[0]
            itemSize2.text = itemSizes?[1]
            itemSize3.text = itemSizes?[2]
            itemImg.image = UIImage(named: item.imagePath!)
            
        }
        
    }
    
}

extension ItemVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if (itemSelected?.quantity != "0") {
            self.colorCollectionView.backgroundView = nil
            return 1
        }
        
        //If the item selected is out of stock => Background shows uilabel out of stock
        let rect = CGRect(x: 0, y: 0, width: self.colorCollectionView.bounds.size.width, height: self.colorCollectionView.bounds.size.height)
        let outOfStockLabel: UILabel = UILabel(frame: rect)
        outOfStockLabel.text = "Out of stock"
        outOfStockLabel.textColor = UIColor.red
        outOfStockLabel.textAlignment = NSTextAlignment.left
        self.colorCollectionView.backgroundView = outOfStockLabel
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (itemSelected?.quantity != "0") {
            return (itemColors?.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorDetailCell", for: indexPath)
        
        cell.backgroundColor = UIColor(hexString: (self.itemColors?[indexPath.item])!)
        
        return cell
    }
}
