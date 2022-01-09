//
//  HomeTableViewCell.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var albumTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func coinfigurCell (albumObj:Album){
        
        self.albumTitleLabel.text = albumObj.albumTitle
    }
    
    
}
