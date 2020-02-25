//
//  DetailViewController.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/25/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ViewModelProvided {

    internal var viewModel: DetailViewModel!
    
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureHierarchy()
    }

}

extension DetailViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: self.view.bounds,collectionViewLayout: .init())
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        collectionView.backgroundColor = .blue
    }
}
