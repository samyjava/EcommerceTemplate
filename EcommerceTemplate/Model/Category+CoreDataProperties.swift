//
//  Category+CoreDataProperties.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/23/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var coverImage: URL?
    @NSManaged public var coverVideo: URL?
    @NSManaged public var desc: String?
    @NSManaged public var order: Int16
    @NSManaged public var size: Int16
    @NSManaged public var title: String?
    @NSManaged public var items: NSSet?
    @NSManaged public var section: Section?
    @NSManaged public var tags: NSSet?

}

// MARK: Generated accessors for items
extension Category {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension Category {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}
