//
//  HomeTableViewCell.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import UIKit
import SkeletonView
class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var albumTitleLabel: UILabel!
    
    @IBOutlet private weak var albumIconImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func coinfigurCell (albumObj:Album){
        
        self.albumTitleLabel.text = albumObj.albumTitle
    }
    
    func startAnimateSkeltonCell(){
        let skeltonViewsArray :[UIView] = [albumTitleLabel,albumIconImg]
        startSkelton(skeltonViewsArray)
    }
    
    
}
