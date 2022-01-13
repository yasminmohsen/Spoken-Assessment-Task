//
//  HomeTableViewCell.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import UIKit
import SkeletonView
class HomeTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet private weak var albumTitleLabel: UILabel!
    @IBOutlet private weak var albumIconImg: UIImageView!
    
    //MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Rendering Data On The Cell :
    func coinfigurCell (albumObj:Album){
        self.albumTitleLabel.text = albumObj.albumTitle
    }
    
    /// Start Animated SkeltonView On The Cell :
    func startAnimateSkeltonCell(){
        let skeltonViewsArray :[UIView] = [albumTitleLabel,albumIconImg]
        startSkelton(skeltonViewsArray)
    }
    
    
}
