//
//  Item.swift
//  E-SHOP
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
        self.desc = itemDict["description"] as? String
        self.size = itemDict["size"] as? String
        self.stars = itemDict["stars"] as? String
        self.quantity = itemDict["quantity"] as? String
        self.imagePath = itemDict["imagePath"] as? String
        self.colors = itemDict["colors"] as? String
        self.about = itemDict["about"] as? String
    }
    
    
   static func retrieveItems(completionHandler: @escaping ([Item]) -> ()) {
    
    DispatchQueue.global(qos: .userInteractive).async {
     
        var items = [Item]()
    
    
        let requestURL = NSURL(string: "http://localhost:8888/E-SHOP/getProducts.php")
    
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
    
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            //exiting if there is some error
            if error != nil{
                print("error is \(error)")
                return;
            }
            else {
            do {
             
                let productsJSON = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject]
                
                if let jsonDict = productsJSON {
                    let itemDicts = jsonDict["products"] as! [[String : AnyObject]]
                    for itemDict in itemDicts {
                        let item = Item(itemDict: itemDict)
                        items.append(item)
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(items)
                    }
                }
                
            } catch {
                print(error)
            }
               
            }
        }
        
        task.resume()
        
    }
    }

    func getColors(item: Item) -> [String] {

            return (item.colors?.components(separatedBy: " "))!
    }
    
    func getSize(item: Item) -> [String] {
        
        return (item.size?.components(separatedBy: " "))!
    }
    
}


