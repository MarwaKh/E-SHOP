//
//  Item.swift
//  TASCH
//
//  Created by My Computer on 2017-06-09.
//  Copyright © 2017 Marwa. All rights reserved.
//

import Foundation

class Item {
    
    var name : String?
    var price : String?
    var desc : String?
    var colors : String?
    var size : String?
    var stars : String?
    var quantity : String?
    var imagePath : String?
    var about : String?
    
    
    
    init(itemDict: [String : AnyObject]) {
        self.name = itemDict["name"] as? String
        self.price = itemDict["price"] as? String
        self.desc = itemDict["desc"] as? String
        self.size = itemDict["size"] as? String
        self.stars = itemDict["stars"] as? String
        self.quantity = itemDict["quantity"] as? String
        self.imagePath = itemDict["imagePath"] as? String
        self.colors = itemDict["colors"] as? String
        self.about = itemDict["About"] as? String
    }
    
    
    static func retrieveItems() -> [Item] {
        
        var items = [Item]()
        
        let jsonFile = Bundle.main.path(forResource: "items", ofType: "json")
        let jsonData = NSData(contentsOfFile: jsonFile!)
        
        if let jsonDict = parseJSONData(jsonData: jsonData) {
            let itemDicts = jsonDict["items"] as! [[String : AnyObject]]
            for itemDict in itemDicts {
                let item = Item(itemDict: itemDict)
           
                items.append(item)
            }
        }
   
        return items
        
    }
    
    static func parseJSONData(jsonData: NSData?) -> [String : AnyObject]? {
        
        if let data = jsonData {
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]
                return jsonDict
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
    
    func getColors(item: Item) -> [String] {

            return (item.colors?.components(separatedBy: " "))!
    }
    
    func getSize(item: Item) -> [String] {
        
        return (item.size?.components(separatedBy: " "))!
    }
    
}


