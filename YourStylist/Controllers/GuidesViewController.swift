//
//  GuidesViewController.swift
//  YourStylist
//
//  Created by Onur Mavitas on 1.09.2020.
//  Copyright © 2020 Onur Mavitas. All rights reserved.
//

import UIKit
import CoreData

class GuidesViewController: UIViewController {
    static let badgeElementKind = "badge-element-kind"
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<GuideCollection, Guide>!
    private let guideCollections = DataSource.shared.guideCol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureDataSource()
        configureSnapshot()
    }
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
//        collectionView.register(BadgeSupplementaryView.self, forSupplementaryViewOfKind: GuidesViewController.badgeElementKind, withReuseIdentifier: BadgeSupplementaryView.reuseIdentifier)
        collectionView.collectionViewLayout = configureCollectionViewLayout()
    }
}

//MARK: - Collection View

extension GuidesViewController {
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
//            //define an anchor point for the badge supplementary view in relation to the item
//            let anchorEdges: NSDirectionalRectEdge = [.top, .trailing]
//            //define an offset from those edges
//            let offSet = CGPoint(x: 0.3, y: -0.3)
//            //use these values to create an NSCOllectionLayoutAnchor
//            let badgeAnchor = NSCollectionLayoutAnchor(edges: anchorEdges, fractionalOffset: offSet)
//            //specify a badge size
//            let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
//            //use all of these attributes to create a badge in the layout
//            let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: GuidesViewController.badgeElementKind, containerAnchor: badgeAnchor)
//            //amend the NSCollectionLayoutItem initializer to accept a supplementary item (done below)
//
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 5
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

//MARK: - Diffable Data Source

extension GuidesViewController {
    
    typealias GuideDataSource = UICollectionViewDiffableDataSource<GuideCollection, Guide>
    func configureDataSource() {
        dataSource = GuideDataSource(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, guide: Guide) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GuidesCell.reuseIdentifier, for: indexPath) as? GuidesCell else {
                return nil
            }
            
            cell.titleLabel.text = guide.title
            cell.snippetLabel.text = guide.snippet
            cell.guideImage.image = UIImage(named: guide.thumbnail)!
            // add a border
            cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.layer.borderWidth = 0.1
            cell.layer.cornerRadius = 3
            return cell
        })
        dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if let self = self, let titleSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier, for: indexPath) as? TitleSupplementaryView {
                
                let guideCollection = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                titleSupplementaryView.textLabel.text = guideCollection.title
                
                return titleSupplementaryView
            } else {
                return nil
            }
        }
//        //configure data source for the item badges
//        dataSource.supplementaryViewProvider = { [weak self] (
//            collectionView: UICollectionView,
//            kind: String,
//            indexPath: IndexPath) -> UICollectionReusableView? in
//
//            guard
//                let self = self,
//                let guide = self.dataSource.itemIdentifier(for: indexPath),
//                let badgeView = collectionView.dequeueReusableSupplementaryView(ofKind: GuidesViewController.badgeElementKind, withReuseIdentifier: BadgeSupplementaryView.reuseIdentifier, for: indexPath) as? BadgeSupplementaryView
//                else {
//                    return nil
//            }
//
//            if guide.favourite {
//                badgeView.isHidden = false
//            } else {
//                badgeView.isHidden = true
//            }
//            return badgeView
//        }
    }
    
    
    func configureSnapshot() {
        var currentSnapshot = NSDiffableDataSourceSnapshot<GuideCollection, Guide>()
        
        guideCollections.forEach { (collection) in
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.guides)
        }
        
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

//MARK: - UICollectionViewDelegate

extension GuidesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let guide = dataSource.itemIdentifier(for: indexPath), let guideDetailController = storyboard?.instantiateViewController(identifier: GuideDetailController.identifier, creator: { coder in
            return GuideDetailController(coder: coder, guide: guide)
        }) {
            show(guideDetailController, sender: nil)
        }
    }
}

//MARK: - Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//        }
