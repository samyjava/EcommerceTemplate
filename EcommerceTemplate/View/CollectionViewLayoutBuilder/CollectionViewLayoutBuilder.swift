//
//  CollectionViewSectionBuilder.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/18/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

enum SectionType : Int16 {
    case singleCol = 0
    case doubleCol = 1
    case fourInAGroup = 2
    case oneBigTwoSmallInAGroup = 3
}

struct CollectionViewLayoutBuilder {
    func createSection(sectionType: SectionType, orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior, sizeFactor: CGFloat) -> NSCollectionLayoutSection {
        var containerGroup: NSCollectionLayoutGroup? = nil
        
        switch sectionType {
        case .singleCol:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 * sizeFactor), heightDimension: .fractionalHeight(1.0 * sizeFactor)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let isOrthOff = orthogonalScrollingBehavior == .none
            containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(isOrthOff ? 1.0 * sizeFactor : 0.9 * sizeFactor), heightDimension: .fractionalWidth(isOrthOff ? 1.0 * sizeFactor : 0.9 * sizeFactor)), subitems: [item])
            
        case .doubleCol:
            let item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5 * sizeFactor), heightDimension: .fractionalHeight(1.0 * sizeFactor)))
            let item2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5 * sizeFactor), heightDimension: .fractionalHeight(1.0 * sizeFactor)))
            item1.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            item2.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9 * sizeFactor), heightDimension: .fractionalWidth(0.9 * sizeFactor)), subitems: [item1,item2])
        case .fourInAGroup:
            let item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5 * sizeFactor), heightDimension: .fractionalHeight(1.0 * sizeFactor)))
            item1.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let item2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5 * sizeFactor), heightDimension: .fractionalHeight(1.0 * sizeFactor)))
            item2.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 * sizeFactor), heightDimension: .fractionalHeight(0.5 * sizeFactor)), subitems: [item1,item2])
            let item3 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5 * sizeFactor), heightDimension: .fractionalHeight(1.0 * sizeFactor)))
            item3.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let item4 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5 * sizeFactor), heightDimension: .fractionalHeight(1.0 * sizeFactor)))
            item4.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 * sizeFactor), heightDimension: .fractionalHeight(0.5 * sizeFactor)), subitems: [item3,item4])
            
            containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9 * sizeFactor), heightDimension: .fractionalHeight(0.9 * sizeFactor)), subitems: [group1,group2])
        case .oneBigTwoSmallInAGroup:
            let leadingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7 * sizeFactor),
                                                   heightDimension: .fractionalHeight(1.0 * sizeFactor)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
            
            let trailingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 * sizeFactor),
                                                   heightDimension: .fractionalHeight(0.3 * sizeFactor)))
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
            let trailingGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3 * sizeFactor),
                                                   heightDimension: .fractionalHeight(1.0 * sizeFactor)),
                subitem: trailingItem, count: 2)
            
            containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85 * sizeFactor),
                                                   heightDimension: .fractionalHeight(0.4 * sizeFactor)),
                subitems: [leadingItem, trailingGroup])
        }
        
        let section = NSCollectionLayoutSection(group: containerGroup!)
        section.orthogonalScrollingBehavior = orthogonalScrollingBehavior
        return section
    }
    
    func createLayout(sections: [(SectionType,UICollectionLayoutSectionOrthogonalScrollingBehavior)], sizeFactor: CGFloat) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return self.createSection(sectionType: sections[sectionIndex].0, orthogonalScrollingBehavior: sections[sectionIndex].1, sizeFactor: sizeFactor)
        }
        return layout
    }
}
