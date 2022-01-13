//
//  SplashScreenViewController.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 13/01/2022.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    
    @IBOutlet weak var appImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnimateView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {[weak self] in
            guard let self = self else {return}
            if let vc =  self.storyboard?.instantiateViewController(identifier: "ProfileVC") as? ProfileViewController{ self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    
    private func AnimateView(){
        
        UIView.animate(withDuration: 3 , delay:0 ,options:.curveEaseIn) {[weak self] in
            guard let self = self else {return}
            
            self.appImage.alpha = 0
            let scalTransform = CGAffineTransform(scaleX: 3, y: 3)
            self.appImage.transform = scalTransform
            self.view.backgroundColor = .white
            
        }
    }
    
}
