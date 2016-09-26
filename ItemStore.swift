//
//  ItemStore.swift
//  Homepwner
//
//  Created by Alecsandra Konson on 9/21/16.
//  Copyright © 2016 Apperator. All rights reserved.
//

import UIKit

class ItemStore { // no need to inherit from NSObject 
    
    var allItems = [Item]()
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
}
