//
//  ItemsViewConroller.swift
//  Homepwner
//
//  Created by Alecsandra Konson on 9/19/16.
//  Copyright © 2016 Apperator. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    struct SectionItems {
        var sectionName: String!
        var sectionObjects: [Item]!
    }
    
    var sectionItemsArray = [SectionItems]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var lessThan50Array = [Item]()
        var moreThan50Array = [Item]()
        
        for item in itemStore.allItems {
            if item.valueInDollars < 51 {
                lessThan50Array.append(item)
            } else {
                moreThan50Array.append(item)
            }
        }
        
        lessThan50Array.sort(by: {$0.valueInDollars < $1.valueInDollars})
        moreThan50Array.sort(by: {$0.valueInDollars < $1.valueInDollars})
        
        sectionItemsArray = [SectionItems(sectionName: "Less Than $50", sectionObjects: lessThan50Array),
                             SectionItems(sectionName: "More Than $50", sectionObjects: moreThan50Array)
                            ]
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsetsMake(statusBarHeight, 0, 0, 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "green_alecs"))
        
    }
    
    // Using dependency injection through a property to give this controller a store
    // Upon app launch, AppleDelegate.swift fires didFinishLaunchingWithOptions and there it instantiates 
    // this itemStore, copulating it with the itemStore array.
    var itemStore: ItemStore!
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionItemsArray[section].sectionObjects.count
        
    }
    
    // set number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionItemsArray.count
    }
    
    // set titles of sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionItemsArray[section].sectionName

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = sectionItemsArray[indexPath.section].sectionObjects[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        //if it's the last item in list, don't print dollar value
        if item.valueInDollars == 100000 {
            tableView.rowHeight = 44

        } else {
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            cell.textLabel?.font = UIFont(name: "Arial", size: 20)

        }
        
        // This doesn't appear to be working. Can't see background image
        cell.backgroundColor = UIColor.clear

        return cell
        
    }
    
}
