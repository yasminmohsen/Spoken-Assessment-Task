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
    lazy var homePublishSubj = PublishSubject<User>()
    init(apiService :ApiServiceProtocol = NetworkManager()) {
        self.apiService = apiService
        disposeBag = DisposeBag()
    }
    
    
    func fetchHomeData(){
        
        
        
        
        
       let homeObserv = apiService.fetchUser()
        homeObserv.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background)).observe(on: MainScheduler.asyncInstance).subscribe(onNext: {[weak self] user in
            self?.homePublishSubj.onNext(user)
            
        }, onError: { error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
        
        
        
        
    }
    
    
    
    
    
    
}
