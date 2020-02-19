//
//  CategoryViewModel.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/19/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

struct CategoryViewModel {
    
    var mainDataSource: UICollectionViewDiffableDataSource<Section, Category>!
    enum Section: CaseIterable {
        case main
        case sub
    }
    
    let appDelegate: AppDelegate
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
    
    mutating func configureCollectionView(collectionView: UICollectionView){
        mainDataSource = UICollectionViewDiffableDataSource<Section, Category>(collectionView: collectionView){
            (collectionView: UICollectionView, indexPath: IndexPath,
            category: Category) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SCCell", for: indexPath) as! CategoryCollectionViewCell
            cell.configure(for: category)
            return cell
        }
        
        var categoryService = CategoryService(appDelegate: UIApplication.shared.delegate as! AppDelegate)
        let fetchedObjects = try! categoryService.getAllCategories()
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Category>()
        snapShot.appendSections([.main])
        let data1 = fetchedObjects.filter{Int($0.title!)! < 10}.sorted{Int($0.title!)! < Int($1.title!)!}
        snapShot.appendItems(data1)
        
        snapShot.appendSections([.sub])
        let data2 = fetchedObjects.filter{Int($0.title!)! >= 10}.sorted{Int($0.title!)! < Int($1.title!)!}
        snapShot.appendItems(data2)
        mainDataSource.apply(snapShot)
    }
}
