//
//  CategoryServiceType.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/19/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import Foundation

protocol CategoryServiceType {
    mutating func getAllCategories() throws -> [Category] 
}
