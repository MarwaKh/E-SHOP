//
//  Item.swift
//  TASCH
//
//  Created by My Computer on 2017-06-09.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class Item: NSObject {

    var name : String?
    var price : NSNumber?
    var desc : String?
    var colors : [Colour]?
    var size : String?
    var starts : NSNumber?
    var quantity : NSNumber?
    var imagePath : NSURL?
    
 
}

class Colour: NSObject {
    
    var id : String?
    
}
