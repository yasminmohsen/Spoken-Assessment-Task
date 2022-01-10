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
    
    var apiService :ApiServiceProtocol!
    let disposeBag = DisposeBag()
    lazy var imageBehaviourRelay = BehaviorRelay<[AlbumImage]>(value: [])
    

    
    init(apiService :ApiServiceProtocol = NetworkManager()) {
        self.apiService = apiService
       
    }
    
    
    
    
    func fetchImages(albumId:Int){
        
      let imagesObserve = apiService.fetchPhotos(albumId: albumId)
        
        imagesObserve.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background)).observe(on: MainScheduler.asyncInstance).subscribe(onNext: {[weak self] albumImage in
            guard let self = self else {return}
            
                 self.imageBehaviourRelay.accept(albumImage)
            

             }, onError: { error in
//                 print(error.localizedDescription)
                debugPrint(error.localizedDescription)
             }).disposed(by: disposeBag)

 
    
    }
        
    func filteredContacts( query: String) -> [AlbumImage] {
      
        let filteredContacts = imageBehaviourRelay.value.filter({ query.isEmpty || ($0.imageTitle.lowercased().contains(query.lowercased()))})
        return filteredContacts
      
    }
    
    
}
