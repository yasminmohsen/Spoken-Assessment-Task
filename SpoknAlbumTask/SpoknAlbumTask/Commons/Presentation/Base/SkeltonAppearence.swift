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

///Start AnimatedGradient
func startSkelton(_ skiltonViewArray:[UIView]){
    
skiltonViewArray.forEach({ obj in
     obj.showAnimatedGradientSkeleton()}
)}
    
///Hide AnimatedGradient
func stopSkelton(_ skiltonViewArray:[UIView]){
    
    skiltonViewArray.forEach({ obj in
     obj.hideSkeleton()})
}
