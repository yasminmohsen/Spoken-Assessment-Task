//
//  HomeViewController.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import UIKit
import RxCocoa
import RxSwift
import SkeletonView
class HomeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var userNamelabel: UILabel!
    
    @IBOutlet private weak var userAddressLabel: UILabel!
    
    @IBOutlet private weak var userZipCodeLabel: UILabel!
    
    @IBOutlet private weak var myAlbumsLabel: UILabel!
    
    @IBOutlet private weak var albumTableView: UITableView!
    
    @IBOutlet private weak var userImg: UIImageView!
    
    @IBOutlet private weak var overlayTableView: UITableView!
    
    //MARK: - Properties
    private lazy var homeViewModel = HomeViewModel()
    
    private let disposeBag = DisposeBag()
    
    private var skiltonViewArray : [UIView]?
    
    //MARK: - Setup Calling For Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skiltonViewArray = [userNamelabel,userAddressLabel,userZipCodeLabel,myAlbumsLabel,userImg]
        bindViewModel()
        setupActionObserves()
        homeViewModel.fetchHomeData() ///Call ViewModel Fetching Func To Fetch HomeData From Api
        
    }
    
    //MARK: - BindingViewModel Function :
    
    private func bindViewModel(){
        
        ///listen to changing in isLoadingBehaviourRelay to hide or show skeltonView :-
        homeViewModel.isLoadingBehaviourRelay.skip(1).subscribe(onNext: { [weak self] isLoading in
            
            guard let self = self else {return}
            guard let skiltonViewArray = self.skiltonViewArray else {return}
            if(!isLoading){
                stopSkelton(skiltonViewArray)
                // Hide the overLayTable (it's a workaround as rxTable doesn't work with SkeltonView) :
                self.overlayTableView.isHidden = true
            }
            else {
                startSkelton(skiltonViewArray)
            }
        }).disposed(by: disposeBag)
        
        
        ///listen to changing in errorBehaviourRelay to show alert when error  :-
        homeViewModel.errorBehaviourRelay.skip(1).subscribe(onNext: { [weak self] error in
            guard let self = self else {return}
            showSimpleAlert(title: "Error", message: error, viewRef: self)
        }).disposed(by: disposeBag)
        
        
        homeViewModel.homePublishSubj      ///Bind userName to userNameLabel
            .map {return $0.user.name}
            .bind(to: userNamelabel.rx.text)
            .disposed(by: disposeBag)
        
        
        homeViewModel.homePublishSubj  ///Bind userAddress to userAddressLabel
            .map {return "\($0.user.address.street),\($0.user.address.suite),\($0.user.address.city)"}
            .bind(to:userAddressLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        homeViewModel.homePublishSubj   ///Bind userAddress.zipcode to userZipCodeLabel
            .map {return $0.user.address.zipcode}
            .bind(to: userZipCodeLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        homeViewModel.homePublishSubj    ///Bind userAlbum to AlbumTableView
            .map({return $0.albums})
            .bind(to: albumTableView.rx.items(cellIdentifier: "cell", cellType: HomeTableViewCell.self)){row , item ,cell in
                
                cell.coinfigurCell(albumObj: item)
                
            }.disposed(by: disposeBag)
    }
    
    
    //MARK: - Setup Trigger Cell Action (setupActionObserves) Function
    private func setupActionObserves(){
        /// Trigger cellSelecting Action
        albumTableView
            .rx
            .modelSelected(Album.self)
            .subscribe(onNext: { [weak self] album in
                        guard let self = self else {return}
                        if let albumImgVC = self.storyboard?.instantiateViewController(identifier: "AlbumImgVC")as?AlbumImageViewController {
                            // set Properties to AlbumImageViewController
                            albumImgVC.albumId = album.albumID
                            albumImgVC.albumTitle = album.albumTitle
                            self.navigationController?.pushViewController(albumImgVC, animated: true)
                            
                        }}).disposed(by: disposeBag)
        
    }
}

