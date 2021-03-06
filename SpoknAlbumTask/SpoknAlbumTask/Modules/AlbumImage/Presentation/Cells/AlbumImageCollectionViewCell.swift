//
//  AlbumImageCollectionViewCell.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import UIKit
import Kingfisher
import SkeletonView
class AlbumImageCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet  private weak var albumImage: UIImageView!
    
    //MARK: - Functions
    
    func configuralbumImageCell(albumImageObj : AlbumImage)
    
    {
        let url = URL(string: albumImageObj.imageURL)
        albumImage.kf.setImage(with: url)
       
    }
    
    func startAnimateSkeltonCell(){
        [albumImage].startAnimationForSkeltonViewes()
    }
}




