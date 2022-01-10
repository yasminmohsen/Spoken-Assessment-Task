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
    lazy var imageBehaviourRelay = BehaviorRelay<[AlbumImage]>(value: [])
    var albumId :Int!
    var disposeBag : DisposeBag!
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUi()
        disposeBag = DisposeBag()
        bindViewModel()
        albumImageViewModel.fetchImages(albumId: albumId)
    }

 
    func bindViewModel(){
        
        
        let query = searchBar.rx.text
                .orEmpty
                .distinctUntilChanged()

        Observable.combineLatest(albumImageViewModel.imageBehaviourRelay, query) { [unowned self] (allContacts, query) -> [AlbumImage] in
            return self.albumImageViewModel.filteredContacts(with: allContacts, query: query)
                }
        .bind(to: imageCollectionView.rx.items(cellIdentifier: "cell", cellType: AlbumImageCollectionViewCell.self)){ row , item ,cell in
            cell.configuralbumImageCell(albumImageObj: item)
    }.disposed(by: disposeBag)

        }
   
    }
    


extension AlbumImageViewController {
    
    
    func setUpUi(){
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
         
         item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)

         
         let horizontlGgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)
         
         
         let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)), subitem: item, count: 2)
         
         
         let mainGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitems: [horizontlGgroup,verticalGroup])
         
         
         
         let section = NSCollectionLayoutSection(group: mainGroup)
         
         
         let layout = UICollectionViewCompositionalLayout(section: section)
         
         imageCollectionView.collectionViewLayout = layout
         imageCollectionView.setNeedsLayout()
    }
    
    
    
    
    
    
}
