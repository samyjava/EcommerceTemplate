//
//  CategoryService.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/19/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit
import CoreData

struct CategoryService: CategoryServiceType {
    
    var appDelegate: AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    mutating func getAllCategories() throws -> [Category] {
        let requset: NSFetchRequest<Category> = Category.fetchRequest()
        var result: [Category]
        do {
            result = try self.context.fetch(requset)
        } catch {
            throw error
        }
        return result
    }
}
