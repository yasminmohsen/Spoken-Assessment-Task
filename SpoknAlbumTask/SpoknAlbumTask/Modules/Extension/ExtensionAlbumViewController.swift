//
//  ExtensionAlbumViewController.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 10/01/2022.
//

import Foundation
import UIKit
extension AlbumImageViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumImageCollectionViewCell
        
        cell.startAnimateSkeltonCell()
        
        return cell
    }
    
    
    
    func setUpUi(){
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
         
         item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)

         
         let horizontlGgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)
         
         
         let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), subitem: item, count: 2)
         
         
         let mainGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [horizontlGgroup,verticalGroup])
         
         
         
         let section = NSCollectionLayoutSection(group: mainGroup)
         
         
         let layout = UICollectionViewCompositionalLayout(section: section)
         
         imageCollectionView.collectionViewLayout = layout
        overLayCollectionView.collectionViewLayout = layout
         imageCollectionView.setNeedsLayout()
    }
    
    
    
    
    
    
}
