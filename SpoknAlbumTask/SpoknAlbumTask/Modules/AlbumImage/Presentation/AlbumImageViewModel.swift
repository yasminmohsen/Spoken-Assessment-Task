//
//  AlbumImageViewModel.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import RxSwift
import Moya
import RxCocoa
class AlbumImageViewModel {
    
    //MARK: - Proprties
    var apiService :ApiServiceProtocol!
    
    lazy var imageBehaviourRelay = BehaviorRelay<[AlbumImage]>(value: [])
    
    lazy var isLoadingBehaviourRelay =  BehaviorRelay<Bool>(value: true)
    
    lazy var errorBehaviourRelay =  BehaviorRelay<String>(value: "")
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Set ApiService
    init(apiService :ApiServiceProtocol = NetworkManager()) {
        self.apiService = apiService
    }
    
    //MARK: - Fetching Images From Api
    
    func fetchImages(albumId:Int){
        isLoadingBehaviourRelay.accept(true) // Waiting For Data
        
        apiService.fetchPhotos(albumId: albumId)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: {[weak self] albumImage in
                guard let self = self else {return}
                self.imageBehaviourRelay.accept(albumImage) // Emit imagesArray
                self.isLoadingBehaviourRelay.accept(false)
                
            }, onError: { [weak self] error in
                guard let self = self else {return}
                self.errorBehaviourRelay.accept(CustomError.localizedError(error: error)) // Emit Error
            }).disposed(by: disposeBag)
    }
    
    //MARK: - Filtering Images
    
    func filteredContacts( query: String) -> [AlbumImage] {
        
        let filteredContacts = imageBehaviourRelay.value.filter({ query.isEmpty || ($0.imageTitle.lowercased().contains(query.lowercased()))})
        return filteredContacts
        
    }
    
    
}
