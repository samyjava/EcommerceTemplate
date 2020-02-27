//
//  ItemServiceType.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/26/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

protocol ItemServiceType {
    mutating func getAllItems(in category: Category) throws -> [Item]
}
