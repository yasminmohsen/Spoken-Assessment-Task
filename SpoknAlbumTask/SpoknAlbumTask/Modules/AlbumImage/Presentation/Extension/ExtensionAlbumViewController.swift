//
//  ExtensionAlbumViewController.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 10/01/2022.
//

import Foundation
import UIKit

extension AlbumImageViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //MARK: - Implement overlayCollectionView DataSource & Delegate :
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumImageCollectionViewCell
        
        cell.startAnimateSkeltonCell()
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width/3.0
        let cellHeight = cellWidth

        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    //MARK: - Implement imageCollectionView CompositionalLayout :
    
    func setUpUi(){
        
        let count:Double = Double(countBehaviourRelay.value > 0 ? countBehaviourRelay.value : 1)
        var itemFracWidth :Double = 1/3
   
        switch count {
        case 1...2:
            itemFracWidth = 1/2
        default:
            itemFracWidth = 1/3
        }
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(CGFloat(itemFracWidth)), heightDimension: .fractionalHeight(1)))
        
        let horizontlGgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)),subitems: [item])

         let section = NSCollectionLayoutSection(group: horizontlGgroup)
        
         let layout = UICollectionViewCompositionalLayout(section: section)
  
        imageCollectionView.collectionViewLayout = layout
        imageCollectionView.setNeedsLayout()

    }
    
}
