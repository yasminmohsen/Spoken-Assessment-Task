//
//  SkeltonAppearence.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 12/01/2022.
//

import Foundation
import UIKit
import SkeletonView


func startSkelton(_ skiltonViewArray:[UIView]){
    
skiltonViewArray.forEach({ obj in
     obj.showAnimatedGradientSkeleton()}
)}
    

func stopSkelton(_ skiltonViewArray:[UIView]){
    
    skiltonViewArray.forEach({ obj in
     obj.hideSkeleton()})
}
