//
//  AlbumImageViewController.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumImageViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var overLayCollectionView: UICollectionView!
    
    //MARK: - Properties
    lazy var albumImageViewModel = AlbumImageViewModel()
    private let disposeBag = DisposeBag()
    var albumId :Int!
    var albumTitle :String!
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = albumTitle
        setUpUi()
        bindViewModel()
        setupActionObserves()
        ///Call ViewModel Fetching Func To Fetch Images  From Api
        albumImageViewModel.fetchImages(albumId: albumId!)
    }
    
    
    
    func bindViewModel(){
        
        albumImageViewModel.isLoadingBehaviourRelay.skip(1).subscribe(onNext: { [weak self] isLoading in
            guard let self = self else {return}
            if(!isLoading){
                UIView.animate(withDuration:2) {
                    self.overLayCollectionView.alpha = 0
                }
            }
        }).disposed(by: disposeBag)
        
        
    
        
        
        ///1- get the search query from searchText
        let query = searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(100), scheduler: MainScheduler.asyncInstance)
        
        ///2- filter the images array and returned filtered array as observable then bind it collectionView
        Observable.combineLatest(albumImageViewModel.imageBehaviourRelay, query) { [unowned self] (allImages, query) -> [AlbumImage] in
            return self.albumImageViewModel
                .filteredContacts( query: query)
        }
        .bind(to: imageCollectionView
                .rx
                .items(cellIdentifier: "cell", cellType: AlbumImageCollectionViewCell.self))
        { row , item ,cell in
            cell.configuralbumImageCell(albumImageObj: item)
        }.disposed(by: disposeBag)
        
    }
    
  
    func setupActionObserves(){
        
        imageCollectionView.rx.modelSelected(AlbumImage.self).subscribe(onNext: { [weak self ] img in
            guard let self = self else {return}
            if let imageViewerVC = self.storyboard?.instantiateViewController(identifier: "imageViewerVc")as?ImageViewerViewController{
                imageViewerVC.singleImage = img
                self.present(imageViewerVC, animated: true)
            
            }}).disposed(by: disposeBag)
        
        
    }
    
    
}



