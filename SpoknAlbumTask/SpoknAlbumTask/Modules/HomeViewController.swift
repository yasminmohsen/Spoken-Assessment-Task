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
    
    @IBOutlet weak var userNamelabel: UILabel!
    
    @IBOutlet weak var userAddressLabel: UILabel!
    
    @IBOutlet weak var userZipCodeLabel: UILabel!
    
    @IBOutlet weak var albumTableView: UITableView!
    
    lazy var homeViewModel = HomeViewModel()
    var disposeBag : DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    

    override func viewWillAppear(_ animated: Bool) {
        disposeBag = DisposeBag()
        setUpObserver()
        homeViewModel.fetchHomeData()
        
    }
    
    
    func setUpObserver(){
        albumTableView.delegate = nil
        albumTableView.dataSource = nil
        homeViewModel.homePublishSubj.map {return $0.user.name}.bind(to: userNamelabel.rx.text).disposed(by: disposeBag)
        
        homeViewModel.homePublishSubj.map {return "\($0.user.address.street),\($0.user.address.suite),\($0.user.address.city)"}.bind(to:userAddressLabel.rx.text).disposed(by: disposeBag)
        
        homeViewModel.homePublishSubj.map {return $0.user.address.zipcode}.bind(to: userZipCodeLabel.rx.text).disposed(by: disposeBag)
        
        homeViewModel.homePublishSubj.map({return $0.albums}).bind(to: albumTableView.rx.items(cellIdentifier: "cell", cellType: HomeTableViewCell.self)){row , item ,cell in
            cell.coinfigurCell(albumObj: item)
            
        }.disposed(by: disposeBag)

        
        
        albumTableView.rx.modelSelected(Album.self).subscribe(onNext: { albm in
            if let vc = self.storyboard?.instantiateViewController(identifier: "AlbumImgVC")as?AlbumImageViewController{
            
            
                vc.albumId = albm.albumID
            
                            self.navigationController?.pushViewController(vc, animated: true)
      
            }}).disposed(by: disposeBag)
        
        
    
        }
    
    
    
   
}

