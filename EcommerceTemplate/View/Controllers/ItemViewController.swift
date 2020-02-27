//
//  DetailViewController.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/25/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, ViewModelProvided {

    internal var viewModel: ItemViewModel!
    
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureHierarchy()
        self.viewModel.configureCollectionView(collectionView: self.collectionView)
    }

}

extension ItemViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: self.view.bounds,collectionViewLayout: .init())
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
