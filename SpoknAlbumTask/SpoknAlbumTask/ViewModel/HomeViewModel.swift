//
//  HomeViewModel.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import RxSwift
class HomeViewModel {
    
    var apiService :ApiServiceProtocol!
    var disposeBag :DisposeBag!
    lazy var homePublishSubj = PublishSubject<HomeModel>()
    lazy var albumPublishSubj = PublishSubject<[Album]>()
    init(apiService :ApiServiceProtocol = NetworkManager()) {
        self.apiService = apiService
        disposeBag = DisposeBag()
    }
    
    
    func fetchHomeData(){
        
        let homeObserv = apiService.fetchHomeData()
             homeObserv.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background)).observe(on: MainScheduler.asyncInstance).subscribe(onNext: {[weak self] homeModelData in
               
                 self?.homePublishSubj.onNext(homeModelData)

             }, onError: { error in
                 print(error.localizedDescription)
             }).disposed(by: disposeBag)

 
    
    }
    
    
    
}
