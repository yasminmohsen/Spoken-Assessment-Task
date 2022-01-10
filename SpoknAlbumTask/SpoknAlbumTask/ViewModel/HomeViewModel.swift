//
//  HomeViewModel.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import RxSwift
class HomeViewModel {
    
    private var apiService :ApiServiceProtocol!
    private let disposeBag :DisposeBag!
    lazy var homePublishSubj = PublishSubject<HomeModel>()
    
    
    init(apiService :ApiServiceProtocol = NetworkManager()) {
        self.apiService = apiService
        disposeBag = DisposeBag()
    }
    
    
    //MARK: - Fetching HomeData From Api
    
    func fetchHomeData(){
        let homeObserve = apiService.fetchHomeData()
        homeObserve.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background)).observe(on: MainScheduler.asyncInstance).subscribe(onNext: {[weak self] homeData in
            ///Emit HomeData value to homePublishSubj
            self?.homePublishSubj.onNext(homeData)
            
        }, onError: { error in
            ///Emit Error to homePublishSubj
            self.homePublishSubj.onError(error)
    
        }).disposed(by: disposeBag)
    }
    
}
