//
//  DetailViewModel.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/25/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

struct ItemViewModel {
    
    private let category: Category!
    var mainDataSource: UICollectionViewDiffableDataSource<Int, Item>!
    
    let appDelegate: AppDelegate
    var itemService: ItemServiceType
    let collectionViewLayoutBuilder = CollectionViewLayoutBuilder()
    
    init(appDelegate: AppDelegate, itemService: ItemServiceType, category: Category) {
        self.appDelegate = appDelegate
        self.itemService = itemService
        self.category = category
    }
    
    mutating func configureCollectionView(collectionView: UICollectionView) {
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.reuseIdentifier)
        var sections = try! appDelegate.persistentContainer.viewContext.fetch(Section.fetchRequest()) as! [Section]
        sections = sections.filter{$0.items!.count > 0}
        var sectionsWithType = [(SectionType,UICollectionLayoutSectionOrthogonalScrollingBehavior)]()
        
        sections.forEach{
            let type = SectionType(rawValue: $0.type)!
            sectionsWithType.append((type,.groupPaging))
        }
        
        collectionView.collectionViewLayout = self.collectionViewLayoutBuilder.createLayout(sections: sectionsWithType, sizeFactor: 1.0)
        
        mainDataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: collectionView){
            (collectionView: UICollectionView, indexPath: IndexPath,
            item: Item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
            cell.configure(for: item)
            return cell
        }
        
        let fetchedObjects = try! self.itemService.getAllItems(in: self.category)
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, Item>()
        
        sections.sorted{ $0.order > $1.order}.forEach{ section in
            snapShot.appendSections([Int(section.order)])
            let data = fetchedObjects.filter{ $0.section == section}
            snapShot.appendItems(data)
        }
        mainDataSource.apply(snapShot)
    }
}
