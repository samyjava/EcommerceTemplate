//
//  ItemService.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/26/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit
import CoreData

struct ItemService: ItemServiceType {
    
    var appDelegate: AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    mutating func getAllItems(in category: Category) throws -> [Item] {
        let requset: NSFetchRequest<Item> = Item.fetchRequest()
        var result: [Item]
        do {
            result = try self.context.fetch(requset).filter{ $0.category == category}
        } catch {
            throw error
        }
        return result
    }
}
