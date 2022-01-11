//
//  ExtensionImageViewerViewController.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 11/01/2022.
//

import Foundation
import UIKit
extension ImageViewerViewController{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
}
