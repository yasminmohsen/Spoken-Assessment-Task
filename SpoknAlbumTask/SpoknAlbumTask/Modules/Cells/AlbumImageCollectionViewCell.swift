//
//  AlbumImageCollectionViewCell.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import UIKit
import Kingfisher
class AlbumImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet  private weak var albumImage: UIImageView!
    
    
    func configuralbumImageCell(albumImageObj : AlbumImage)
    
    {
        let url = URL(string: albumImageObj.imageURL)
        albumImage.kf.setImage(with: url)
        
        
        
    }
}
