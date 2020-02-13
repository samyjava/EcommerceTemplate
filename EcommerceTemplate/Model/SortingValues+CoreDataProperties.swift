//
//  SortingValues+CoreDataProperties.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/13/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//
//

import Foundation
import CoreData


extension SortingValues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SortingValues> {
        return NSFetchRequest<SortingValues>(entityName: "SortingValues")
    }

    @NSManaged public var bestMatch: Float
    @NSManaged public var newest: Float
    @NSManaged public var ratingAverage: Float
    @NSManaged public var distance: Float
    @NSManaged public var popularity: Float
    @NSManaged public var averageProductPrice: Float
    @NSManaged public var deliveryCosts: Float
    @NSManaged public var minCost: Float
    @NSManaged public var bestSell: Float
    @NSManaged public var item: Item?

}
