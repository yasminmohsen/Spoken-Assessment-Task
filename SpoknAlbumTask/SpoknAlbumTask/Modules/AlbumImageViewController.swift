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
    
    //MARK: - Properties
    lazy var albumImageViewModel = AlbumImageViewModel()
    private let disposeBag = DisposeBag()
    var albumId :Int!
   
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bindViewModel()
        ///Call ViewModel Fetching Func To Fetch Images  From Api
        albumImageViewModel.fetchImages(albumId: albumId)
    }

 
    func bindViewModel(){
        
        ///1- get the search query from searchText [no need to use debounce as it request data from memory not from server ]
        let query = searchBar.rx.text
                .orEmpty
                .distinctUntilChanged()
        
        ///2- filter the images array and returned filtered array as observable then bind it collectionView
        Observable.combineLatest(albumImageViewModel.imageBehaviourRelay, query) { [unowned self] (allImages, query) -> [AlbumImage] in
            return self.albumImageViewModel.filteredContacts(with: allImages, query: query)
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
