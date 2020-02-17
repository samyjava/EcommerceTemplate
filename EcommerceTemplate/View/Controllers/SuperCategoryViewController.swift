//
//  SuperCategoryViewController.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/13/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit

class SuperCategoryViewController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Category>!
    
    enum Section: CaseIterable {
        case main
        case sub
    }
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
    }
}

extension SuperCategoryViewController {
    func configureHierarchy() {
        mainCollectionView.collectionViewLayout = createLayout()
        mainCollectionView.delegate = self
        mainCollectionView.backgroundColor = .systemBackground
        mainCollectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.view.addSubview(mainCollectionView)
    }
    
    func configureDataSource() {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        
        dataSource = UICollectionViewDiffableDataSource<Section, Category>(collectionView: mainCollectionView){
            (collectionView: UICollectionView, indexPath: IndexPath,
            category: Category) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SCCell", for: indexPath) as! CategoryCollectionViewCell
            cell.configure(for: category)
            print("[\(indexPath.section),\(indexPath.row)]")
            return cell
        }
        
        let fetchedObjects = try! context.fetch(Category.fetchRequest()) as? [Category]
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Category>()
        snapShot.appendSections([.main])
        let data1 = fetchedObjects?.filter{Int($0.title!)! < 10}.sorted{Int($0.title!)! < Int($1.title!)!}
        snapShot.appendItems(data1 ?? [])
        
        snapShot.appendSections([.sub])
        let data2 = fetchedObjects?.filter{Int($0.title!)! >= 10}.sorted{Int($0.title!)! < Int($1.title!)!}
        snapShot.appendItems(data2 ?? [])
        dataSource.apply(snapShot)
    }
    fileprivate func ortScrGrpPg() -> NSCollectionLayoutSection? {
        let leadingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                               heightDimension: .fractionalHeight(1.0)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let trailingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.3)))
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                               heightDimension: .fractionalHeight(1.0)),
            subitem: trailingItem, count: 2)
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                               heightDimension: .fractionalHeight(0.4)),
            subitems: [leadingItem, trailingGroup])
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    fileprivate func ortScrGrpPg2() -> NSCollectionLayoutSection? {
        let leadingItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                               heightDimension: .fractionalHeight(0.4)),
            subitems: [leadingItem])
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            switch sectionIndex {
            case 0:
                return self.ortScrGrpPg()
            case 1:
                return self.ortScrGrpPg2()
            default:
                return nil
            }
        }
        return layout
    }
}

extension SuperCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
