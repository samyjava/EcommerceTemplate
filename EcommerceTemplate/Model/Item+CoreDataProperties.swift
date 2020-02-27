//
//  Item+CoreDataProperties.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/27/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var beforeDiscountPrice: String?
    @NSManaged public var coverImage: URL?
    @NSManaged public var coverVideo: URL?
    @NSManaged public var deliveryCost: Float
    @NSManaged public var desc: String?
    @NSManaged public var inStockCount: Int16
    @NSManaged public var price: String?
    @NSManaged public var size: Int16
    @NSManaged public var status: Int16
    @NSManaged public var title: String?
    @NSManaged public var category: Category?
    @NSManaged public var section: Section?
    @NSManaged public var sortingValues: SortingValues?
    @NSManaged public var tags: NSSet?

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
