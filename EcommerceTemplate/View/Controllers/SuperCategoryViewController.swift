//
//  SuperCategoryViewController.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/13/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

class SuperCategoryViewController: UIViewController, ViewModelProvided {
    
    //Outlets
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    //Properties
    internal var viewModel: CategoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Temporary -------------------
        let categoryService = CategoryService(appDelegate: UIApplication.shared.delegate as! AppDelegate)
        self.setViewModel(viewModel: CategoryViewModel(appDelegate: UIApplication.shared.delegate as! AppDelegate, categoryService: categoryService))
        ///-------------------
        self.viewModel.configureCollectionView(collectionView: mainCollectionView)
        self.mainCollectionView.delegate = self
    }
    
}

extension SuperCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            viewModel.tapOn(category: cell.category, in: self)
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
