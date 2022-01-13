//
//  ProfileViewModel.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya
class ProfileViewModel {
    
    //MARK: - Proprties
    var apiService :ApiServiceProtocol!
    private let disposeBag = DisposeBag()
    private lazy var userBehaviorRelay = BehaviorRelay<User?>(value: nil)
    lazy var profilePublishSubj = PublishSubject<ProfileModel>()
    lazy var isLoadingBehaviourRelay =  BehaviorRelay<Bool>(value: true)
    lazy var errorBehaviourRelay =  BehaviorRelay<String>(value: "")
    
    //MARK: - Set ApiService
    init(apiService :ApiServiceProtocol = NetworkManager()) {
        self.apiService = apiService
    }
    
    
    //MARK: - Fetching ProfileData From Api :
    func fetchProfileData(){
        isLoadingBehaviourRelay.accept(true) // Waiting For Data
          
        apiService.fetchUsers()
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [weak self] usr in
            guard let self = self else{return}
            self.userBehaviorRelay.accept(usr) //Update userBehaviorRelay value
        }, onError: {[weak self] error in
            guard let self = self else{return}
            self.errorBehaviourRelay.accept(CustomError.localizedError(error: error)) // Emit Error
        }).disposed(by: disposeBag)
        
        
        userBehaviorRelay
            .asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] user in
                guard let self = self , let  id = user?.id else{return}
                self.fetchAlbumData(userId: id) // Fetch AlbumData Using UserId
            }).disposed(by: disposeBag)
    }
    
    //MARK: - Fetching AlbumData From Api :
    func fetchAlbumData(userId:Int){
        self.apiService.fetchAlbums(userId: userId)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [weak self] album in
            
            guard let self = self else{return}
            guard let user = self.userBehaviorRelay.value else{return}
            self.isLoadingBehaviourRelay.accept(false) // Stop laoding
            self.profilePublishSubj.onNext(ProfileModel(user: user , albums: album)) // Emit userProfile data
        }, onError: { [weak self ]error in
            guard let self = self else{return}
            self.errorBehaviourRelay.accept(CustomError.localizedError(error: error)) // Emit error 
        }).disposed(by: self.disposeBag)
        
    }
    
}





