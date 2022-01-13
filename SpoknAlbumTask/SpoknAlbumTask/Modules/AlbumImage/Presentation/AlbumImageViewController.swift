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
    @IBOutlet private weak var searchBar: UISearchBar!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var overLayCollectionView: UICollectionView!
    
    //MARK: - Properties
    var albumId :Int!
    
    var albumTitle :String!
    
    var countBehaviourRelay = BehaviorRelay<Int>(value:0)
    
    lazy var albumImageViewModel = AlbumImageViewModel()
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Setup Calling For Functions :
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = albumTitle
        setUpUi()
        bindViewModel()
        setupActionObserves()
        albumImageViewModel.fetchImages(albumId: albumId!)   ///Call ViewModel Fetching Func To Fetch Images  From Api
    }
    
    //MARK: - BindingViewModel Function :
    
    private func bindViewModel(){
        
        ///listen to changing in isLoadingBehaviourRelay to hide or show skeltonView :-
        albumImageViewModel.isLoadingBehaviourRelay.skip(1).subscribe(onNext: { [weak self] isLoading in
            guard let self = self else {return}
            if(!isLoading){
                UIView.animate(withDuration:2) {
                    self.overLayCollectionView.alpha = 0
                }
            }
        }).disposed(by: disposeBag)
        
        
        ///listen to changing in errorBehaviourRelay to show alert when error  :-
        albumImageViewModel.errorBehaviourRelay.skip(1).subscribe(onNext: { [weak self] error in
            guard let self = self else {return}
            showSimpleAlert(title: "Error", message: error, viewRef: self)
        } ).disposed(by: disposeBag)
        
        
        ///listen to changing in countBehaviourRelay to update num of cells in ImageCollectionViewr  :-
        countBehaviourRelay.subscribe(onNext: { [weak self]_ in
            guard let self = self else{return}
            self.setUpUi()
        }).disposed(by: disposeBag)
        
        
        //MARK: - Display Images and FilteredImages :
        
        ///1- get the search query from searchText
        let query = searchBar
            .rx.text
            .orEmpty
        
        ///2- filter the images array and returned filtered array as observable then bind it  to imageCollectionView
        Observable
            .combineLatest(albumImageViewModel.imageBehaviourRelay, query) { [unowned self] (allImages, query) -> [AlbumImage] in
                let filteredArray = self.albumImageViewModel.filteredContacts( query: query)
                countBehaviourRelay.accept(filteredArray.count) // Emit new count
                return filteredArray
            }
            .bind(to: imageCollectionView
                    .rx
                    .items(cellIdentifier: "cell", cellType: AlbumImageCollectionViewCell.self)){ row , item ,cell in
                
                cell.configuralbumImageCell(albumImageObj: item)
                
            }.disposed(by: disposeBag)
        
    }
    
    
    //MARK: - Setup Trigger Cell Action (setupActionObserves) Function :
    private func setupActionObserves(){
        /// Trigger cellSelecting Action
        imageCollectionView
            .rx
            .modelSelected(AlbumImage.self)
            .subscribe(onNext: { [weak self ] img in
                        guard let self = self else {return}
                        if let imageViewerVC = self.storyboard?.instantiateViewController(identifier: "imageViewerVc")as?ImageViewerViewController{
                            imageViewerVC.singleImage = img
                            self.present(imageViewerVC, animated: true)
                            
                        }}).disposed(by: disposeBag)
        
        
    }
    
}



