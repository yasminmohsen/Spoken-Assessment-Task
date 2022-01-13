//
//  HomeViewModel.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya
class HomeViewModel {
    
    //MARK: - Proprties
    var apiService :ApiServiceProtocol!
    private let disposeBag = DisposeBag()
    private lazy var userBehaviorRelay = BehaviorRelay<User?>(value: nil)
    lazy var homePublishSubj = PublishSubject<HomeModel>()
    lazy var isLoadingBehaviourRelay =  BehaviorRelay<Bool>(value: true)
    lazy var errorBehaviourRelay =  BehaviorRelay<String>(value: "")
    
    //MARK: - Set ApiService
    init(apiService :ApiServiceProtocol = NetworkManager()) {
        self.apiService = apiService
    }
    
    
    //MARK: - Fetching HomeData From Api
    func fetchHomeData(){
        
        isLoadingBehaviourRelay.accept(true) // Waiting For Data
        
        apiService.fetchUsers()
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [weak self] usr in
            guard let self = self else{return}
            self.userBehaviorRelay.accept(usr)
        }, onError: {[weak self] error in
            guard let self = self else{return}
            
            self.errorBehaviourRelay.accept(CustomError.localizedError(error: error))
            
        }).disposed(by: disposeBag)
        
        userBehaviorRelay
            .asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] user in
                guard let self = self , let  id = user?.id else{return}
                self.fetchAlbumData(userId: id)
            }).disposed(by: disposeBag)
    }
    
    //MARK: - Fetching AlbumData From Api
    func fetchAlbumData(userId:Int){
        
        self.apiService.fetchAlbums(userId: userId).subscribe(onNext: { [weak self] album in
            guard let self = self else{return}
            
            guard let user = self.userBehaviorRelay.value else{return}
            self.isLoadingBehaviourRelay.accept(false)
            self.homePublishSubj.onNext(HomeModel(user: user , albums: album))
            
        }, onError: { [weak self ]error in
            guard let self = self else{return}
            
           
            self.errorBehaviourRelay.accept(CustomError.localizedError(error: error))
            
        }).disposed(by: self.disposeBag)
        
    }
    
}



/*
 //        self.apiService.getAlbums(userId: userBehaviorRelay.value!.id).subscribe(onNext: { [unowned self] album in
 //            self.homePublishSubj.onNext(HomeModel(user: self.userBehaviorRelay.value!, albums: album))
 //
 //        }).disposed(by: disposeBag)
 
 
 //         userObservable.flatMap({ [unowned self ] user in
 //
 //            self.apiService.getAlbums(userId: user.id)
 //        }).subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background)).observe(on: MainScheduler.asyncInstance).subscribe(onNext: { [unowned self] album in
 //            self.homePublishSubj.onNext(HomeModel(user: self.userBehaviorRelay.value!, albums: album))
 //
 //        }).disposed(by: disposeBag)
 
 
 
 debugPrint(WalletViewModel.self, #line, error.localizedDescription)
 */


