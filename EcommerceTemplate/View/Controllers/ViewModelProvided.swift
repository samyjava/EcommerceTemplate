//
//  ViewModelProvided.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/19/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

protocol ViewModelProvided where Self: UIViewController {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! {get set}
    
    func setViewModel(viewModel: ViewModelType)
}

extension ViewModelProvided {
    func setViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}
