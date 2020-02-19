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
    let sectionBuilder = CollectionViewSectionBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        //Temporary
        self.setViewModel(viewModel: CategoryViewModel(appDelegate: UIApplication.shared.delegate as! AppDelegate))
        self.viewModel.configureCollectionView(collectionView: mainCollectionView)
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
