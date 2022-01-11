//
//  HomeViewModel.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import RxSwift
import RxCocoa
class HomeViewModel {
    
    //MARK: - Proprties
    public var apiService :ApiServiceProtocol!
    private let disposeBag = DisposeBag()
    private lazy var userBehaviorRelay = BehaviorRelay<User?>(value: nil)
    private lazy var albumBehaviorRelay = BehaviorRelay<[Album]>(value: [])
    lazy var homePublishSubj = PublishSubject<HomeModel>()
   
    init(apiService :ApiServiceProtocol = NetworkManager()) {
        self.apiService = apiService
    }
    
    
    //MARK: - Fetching HomeData From Api
    
    func fetchHomeData(){
        
        apiService.getUsers().subscribe(onNext: { [weak self] usr in
            guard let self = self else{return}
            self.userBehaviorRelay.accept(usr)
        }, onError: { error in
          
        }).disposed(by: disposeBag)
        
        
        userBehaviorRelay
            .asObservable()
            .skip(1)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] user in
                guard let self = self , let  id = user?.id else{return}
                self.fetchAlbumData(userId: id)
            }).disposed(by: disposeBag)
    }
    
    //MARK: - Fetching AlbumData From Api
    func fetchAlbumData(userId:Int){
        
        self.apiService.getAlbums(userId: userId).subscribe(onNext: { [weak self] album in
            guard let self = self else{return}
            self.albumBehaviorRelay.accept(album)
        }, onError: { error -> Void in
          
        }).disposed(by: self.disposeBag)
        
        albumBehaviorRelay
            .asObservable()
            .skip(1)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {[weak self] album in
                guard let self = self ,
                      let user = self.userBehaviorRelay.value else{return}
                self.homePublishSubj.onNext(HomeModel(user: user , albums: album))
            }).disposed(by: disposeBag)
        
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


