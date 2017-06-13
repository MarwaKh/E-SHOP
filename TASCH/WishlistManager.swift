//
//  WishlistManager.swift
//  TASCH
//
//  Created by My Computer on 2017-06-10.
//  Copyright © 2017 Marwa. All rights reserved.
//

import Foundation

class WishlistManager: NSObject {
    
    var wishList: [Item] = []
    
    static let sharedInstance: WishlistManager = {
        let instance = WishlistManager()
        return instance
    } ()
    
    
    func addItem(item : Item) {
        wishList.append(item)
    }
    
    func removeItem(index: Int) {
        
        
        wishList.remove(at: index)
}
    
    func StringToFloat(stringValue: String) -> Float {
        return Float(stringValue)!
    }
    
    func totalPrice() -> Float {
        
        var total: Float = 0.0
        
        for item in wishList {
            total += StringToFloat(stringValue: item.price!)
        }
        
        return total
        
    }
}

