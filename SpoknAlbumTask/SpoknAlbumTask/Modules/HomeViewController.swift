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

        setUpObserver()
        homeViewModel.fetchHomeData()
        
    }
    

    func setUpObserver(){
        
        homeViewModel.homePublishSubj.map {return $0.name}.bind(to: userNamelabel.rx.text).disposed(by: disposeBag)
        
        homeViewModel.homePublishSubj.map {return "\($0.address.street),\($0.address.suite),\($0.address.city)"}.bind(to:userAddressLabel.rx.text).disposed(by: disposeBag)
        
        homeViewModel.homePublishSubj.map {return $0.address.zipcode}.bind(to: userZipCodeLabel.rx.text).disposed(by: disposeBag)
        
    }
    
   
}

