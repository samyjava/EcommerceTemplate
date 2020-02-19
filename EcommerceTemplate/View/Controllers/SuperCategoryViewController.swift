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
    let sectionBuilder = CollectionViewSectionBuilder()
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
        
        dataSource = UICollectionViewDiffableDataSource<Section, Category>(collectionView: mainCollectionView){
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
        dataSource.apply(snapShot)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            switch sectionIndex {
            case 0:
                return self.sectionBuilder.createSection(sectionType: .singleCol, orthogonalScrollingBehavior: .groupPaging)
            case 1:
                return self.sectionBuilder.createSection(sectionType: .fourInAGroup, orthogonalScrollingBehavior: .groupPaging)
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
