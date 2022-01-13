//
//  AlertManager.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 13/01/2022.
//

import Foundation
import UIKit


// MARK: - Add Stand-alone Function To Show Simple Alert :

func showSimpleAlert(title: String,message: String, viewRef: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
    
    viewRef.present(alert, animated: true, completion: nil)
}
