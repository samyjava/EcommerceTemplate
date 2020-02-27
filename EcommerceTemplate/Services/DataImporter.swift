//
//  DataImporter.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/22/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

enum DataImporterError: Error {
    case failedToCreateURL
}

struct DataImporter {
    func importTempData() throws {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let url = Bundle.main.url(forResource: "sample", withExtension: "json") else {
            throw DataImporterError.failedToCreateURL
        }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let sectionArray = json as? [[String:Any]] {
                sectionArray.forEach{ section in
                    let newSection = Section(context: context)
                    newSection.order = section["order"] as! Int16
                    newSection.type = section["type"] as! Int16
                    if let categories = section["categories"] as? [[String:Any]] {
                        categories.forEach{ thisCat in
                            let category = Category(context: context)
                            category.coverImage = URL(string: thisCat["coverImage"] as! String)
                            category.coverVideo = URL(string: thisCat["coverVideo"] as! String)
                            category.desc = thisCat["desc"] as? String
                            category.order = thisCat["order"] as! Int16
                            category.title = thisCat["title"] as? String
                            newSection.addToCategories(category)
                        }
                    }
                }
            }
            appDelegate.saveContext()
        } catch {
            throw error
        }
    }
    
    func importItems() throws {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let url = Bundle.main.url(forResource: "items", withExtension: "json") else {
            throw DataImporterError.failedToCreateURL
        }
        do {
            //sample category
            let category = try context.fetch(Category.fetchRequest()).first! as Category
            
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let sectionArray = json as? [[String:Any]] {
                sectionArray.forEach{ section in
                    let newSection = Section(context: context)
                    newSection.order = section["order"] as! Int16
                    newSection.type = section["type"] as! Int16
                    if let items = section["items"] as? [[String:Any]] {
                        items.forEach{ thisItem in
                            let item = Item(context: context)
                            item.title = thisItem["title"] as? String
                            item.desc = thisItem["desc"] as? String
                            item.price = thisItem["price"] == nil ? "" : thisItem["price"] as? String
                            item.beforeDiscountPrice = thisItem["beforeDiscountPrice"] == nil ? "" : thisItem["beforeDiscountPrice"] as? String
                            item.inStockCount = thisItem["inStockCount"] as? Int16 ?? 0
                            item.status = thisItem["status"] as? Int16 ?? 0
                            item.coverImage = thisItem["coverImage"] == nil ? nil : URL(string: thisItem["coverImage"] as! String)
                            item.coverVideo = thisItem["coverVideo"] == nil ? nil : URL(string: thisItem["coverVideo"] as! String)
                            item.category = category
                            newSection.addToItems(item)
                        }
                    }
                }
                appDelegate.saveContext()
            }
        } catch {
            throw error
        }
    }
    
}
