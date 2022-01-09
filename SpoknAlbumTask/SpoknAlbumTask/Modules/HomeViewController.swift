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
    lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    

    override func viewWillAppear(_ animated: Bool) {
        setUpObserver()
        homeViewModel.fetchHomeData()
        
    }
    
    
    func setUpObserver(){
        
        homeViewModel.homePublishSubj.map {return $0.user.name}.bind(to: userNamelabel.rx.text).disposed(by: disposeBag)
        
        homeViewModel.homePublishSubj.map {return "\($0.user.address.street),\($0.user.address.suite),\($0.user.address.city)"}.bind(to:userAddressLabel.rx.text).disposed(by: disposeBag)
        
        homeViewModel.homePublishSubj.map {return $0.user.address.zipcode}.bind(to: userZipCodeLabel.rx.text).disposed(by: disposeBag)
        
        homeViewModel.homePublishSubj.map({return $0.albums}).bind(to: albumTableView.rx.items(cellIdentifier: "cell", cellType: HomeTableViewCell.self)){row , item ,cell in
            cell.coinfigurCell(albumObj: item)
            
        }.disposed(by: disposeBag)
        
    }
    
   
}

