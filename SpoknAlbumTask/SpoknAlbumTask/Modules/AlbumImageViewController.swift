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


    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    lazy var albumImageViewModel = AlbumImageViewModel()
    var albumId :Int!
    var disposeBag : DisposeBag!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUi()
        disposeBag = DisposeBag()
        setUpObserver()
        albumImageViewModel.fetchImages(albumId: albumId)
    }

    
    func setUpObserver(){
        imageCollectionView.delegate = nil
        imageCollectionView.dataSource = nil
        
        albumImageViewModel.albumImagesPublishSubj.bind(to: imageCollectionView.rx.items(cellIdentifier: "cell", cellType: AlbumImageCollectionViewCell.self)){ row , item ,cell in
            cell.configuralbumImageCell(albumImageObj: item)
        }.disposed(by: disposeBag)
        
    
    }
    


}

extension AlbumImageViewController {
    
    
    func setUpUi(){
        
        
    }
    
    
    
    
    
    
}
