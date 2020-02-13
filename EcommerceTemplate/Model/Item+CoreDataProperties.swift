//
//  Item+CoreDataProperties.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/13/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: Float
    @NSManaged public var coverImage: Data?
    @NSManaged public var desc: String?
    @NSManaged public var status: Int16
    @NSManaged public var deliveryCost: Float
    @NSManaged public var inStockCount: Int16
    @NSManaged public var beforeDiscountPrice: Float
    @NSManaged public var coverVideo: Data?
    @NSManaged public var size: Int16
    @NSManaged public var sortingValues: SortingValues?
    @NSManaged public var tags: NSSet?
    @NSManaged public var category: Category?

}

// MARK: Generated accessors for tags
extension Item {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}
