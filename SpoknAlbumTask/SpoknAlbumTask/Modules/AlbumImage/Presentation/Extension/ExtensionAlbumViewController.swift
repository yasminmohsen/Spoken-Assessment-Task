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
        
        let count:Double = Double(countBehaviourRelay.value > 0 ? countBehaviourRelay.value : 9)
        var fracHeight:Double = 1/3
        var itemFracWidth :Double = 1/3
   
        switch count {
        case 1:
            itemFracWidth = 1/2
        case 2:
            fracHeight = 1 / 2
            itemFracWidth = 1/2
        default:
            fracHeight = 1 / 3
            itemFracWidth = 1/3

        }
        
        
    
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(CGFloat(itemFracWidth)), heightDimension: .fractionalHeight(1)))
        let horizontlGgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(CGFloat((fracHeight)))),subitems:[item])
         
        
        horizontlGgroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
         
         let section = NSCollectionLayoutSection(group: horizontlGgroup)
    
         let layout = UICollectionViewCompositionalLayout(section: section)
         
         imageCollectionView.collectionViewLayout = layout
        overLayCollectionView.collectionViewLayout = layout
         imageCollectionView.setNeedsLayout()
    }
    
    
    
    
    
    
}
