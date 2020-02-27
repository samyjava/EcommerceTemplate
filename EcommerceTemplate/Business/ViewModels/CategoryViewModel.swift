//
//  CategoryViewModel.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/19/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

struct CategoryViewModel {
    
    var mainDataSource: UICollectionViewDiffableDataSource<Int, Category>!
    
    let appDelegate: AppDelegate
    var categoryService: CategoryServiceType
    let collectionViewLayoutBuilder = CollectionViewLayoutBuilder()
    
    init(appDelegate: AppDelegate, categoryService: CategoryServiceType) {
        self.appDelegate = appDelegate
        self.categoryService = categoryService
    }
    
    func tapOn(category: Category, in viewController: UIViewController) {
        //
        let itemViewController = ItemViewController()
        let itemService = ItemService(appDelegate: appDelegate)
        let itemViewModel = ItemViewModel(appDelegate: appDelegate, itemService: itemService, category: category)
        itemViewController.setViewModel(viewModel: itemViewModel)
        viewController.present(itemViewController, animated: true)
    }
    
    mutating func configureCollectionView(collectionView: UICollectionView){
        var sections = try! appDelegate.persistentContainer.viewContext.fetch(Section.fetchRequest()) as! [Section]
        sections = sections.filter{$0.categories!.count > 0}
        var sectionsWithType = [(SectionType,UICollectionLayoutSectionOrthogonalScrollingBehavior)]()
        
        sections.forEach{
            let type = SectionType(rawValue: $0.type)!
            sectionsWithType.append((type,.groupPaging))
        }
        
        collectionView.collectionViewLayout = self.collectionViewLayoutBuilder.createLayout(sections: sectionsWithType, sizeFactor: 1.0)
        
        mainDataSource = UICollectionViewDiffableDataSource<Int, Category>(collectionView: collectionView){
            (collectionView: UICollectionView, indexPath: IndexPath,
            category: Category) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SCCell", for: indexPath) as! CategoryCollectionViewCell
            cell.configure(for: category)
            return cell
        }
        
        let fetchedObjects = try! self.categoryService.getAllCategories()
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, Category>()
        
        sections.sorted{ $0.order > $1.order}.forEach{ section in
            snapShot.appendSections([Int(section.order)])
            let data = fetchedObjects.filter{ $0.section == section}.sorted{ $0.order < $1.order}
            snapShot.appendItems(data)
        }
        mainDataSource.apply(snapShot)
    }
}
