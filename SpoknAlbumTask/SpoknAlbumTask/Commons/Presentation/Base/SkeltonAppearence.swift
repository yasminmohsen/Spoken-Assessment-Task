//
//  SkeltonAppearence.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 12/01/2022.
//

import Foundation
import UIKit
import SkeletonView


// MARK: - Add Stand-alone Function To Manage SkeltonView Apperance :

extension Array where Element == UIView {
    
    func startAnimationForSkeltonViewes () {   ///Start AnimatedGradient
        
        self.forEach({$0.showAnimatedGradientSkeleton()})
    }
    
    
    func hideForSkeltonViewes () {     ///Hide AnimatedGradient
        
        self.forEach({$0.hideSkeleton()})
    }
}
