//
//  ImageViewerViewController.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 11/01/2022.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher
class ImageViewerViewController: UIViewController,UIScrollViewDelegate {
    //MARK: - Outlets
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Properties
    var singleImage : AlbumImage?
    
    let disposeBag = DisposeBag()
    
    //MARK: - Functions :
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUi()
        setActionObserver()
    }
    
    private func setupUi(){
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        self.navigationController?.navigationBar.isHidden = true
        guard let img = singleImage else {return}
        guard let url = URL(string:img.imageURL) else {return}
        imageView.kf.setImage(with: url)
        
    }
    
    private  func setActionObserver(){
        
        shareButton                      /// To make Images sharable
            .rx
            .tap
            .subscribe(onNext: { [weak self ] in
                guard let self = self else {return}
                guard let image = self.imageView.image else {return}
                
                let activityController = UIActivityViewController(activityItems: [image],  /// To make Images sharable
                                                                  applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        
        closeButton                      /// To dismiss view
            .rx
            .tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
}
