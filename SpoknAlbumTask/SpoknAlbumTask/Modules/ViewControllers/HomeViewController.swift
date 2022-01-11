//
//  HomeViewController.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var userNamelabel: UILabel!
    @IBOutlet private weak var userAddressLabel: UILabel!
    @IBOutlet private weak var userZipCodeLabel: UILabel!
    
    @IBOutlet weak var myAlbumsLabel: UILabel!
    @IBOutlet private weak var albumTableView: UITableView!
    
    //MARK: - Properties
    private lazy var homeViewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
       
        bindViewModel()
        ///Call ViewModel Fetching Func To Fetch HomeData From Api
        homeViewModel.fetchHomeData()
    }
    
  
    
    func bindViewModel(){
        ///Bind userName to userNameLabel
        homeViewModel.homePublishSubj
            .map {return $0.user.name}
            .bind(to: userNamelabel.rx.text)
            .disposed(by: disposeBag)
        
        ///Bind userAddress to userAddressLabel
        homeViewModel
            .homePublishSubj
            .map {return "\($0.user.address.street),\($0.user.address.suite),\($0.user.address.city)"}
            .bind(to:userAddressLabel.rx.text)
            .disposed(by: disposeBag)
        
        ///Bind userAddress.zipcode to userZipCodeLabel
        homeViewModel.homePublishSubj
            .map {return $0.user.address.zipcode}
            .bind(to: userZipCodeLabel.rx.text)
            .disposed(by: disposeBag)
        
        ///Bind userAlbum to AlbumTableView
        homeViewModel.homePublishSubj
            .map({return $0.albums})
            .bind(to: albumTableView.rx.items(cellIdentifier: "cell", cellType: HomeTableViewCell.self)){row , item ,cell in
            cell.coinfigurCell(albumObj: item)
            
        }.disposed(by: disposeBag)
        
        /// Trigger cellSelecting Action
        albumTableView.rx.modelSelected(Album.self).subscribe(onNext: { [weak self] albm in
           guard let self = self else {return}
           if let albumImgVC = self.storyboard?.instantiateViewController(identifier: "AlbumImgVC")as?AlbumImageViewController{
            albumImgVC.albumId = albm.albumID
            self.navigationController?.pushViewController(albumImgVC, animated: true)
           }}).disposed(by: disposeBag)
        
        homeViewModel.homePublishSubj.subscribe(onError: { error in
                print("****\(error.localizedDescription)")
        }).disposed(by: disposeBag)
        
    }
}

