//
//  AlbumImageViewModel.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import RxSwift
import Moya
class AlbumImageViewModel {
    
    var apiService :ApiServiceProtocol!
    var disposeBag :DisposeBag!
    lazy var albumImagesPublishSubj = PublishSubject<[AlbumImage]>()
    
    
    init(apiService :ApiServiceProtocol = NetworkManager()) {
        self.apiService = apiService
        disposeBag = DisposeBag()
    }
    
    
    
    
    func fetchImages(albumId:Int){
        
      let imagesObserve = apiService.fetchPhotos(albumId: albumId)
        
        imagesObserve.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background)).observe(on: MainScheduler.asyncInstance).subscribe(onNext: {[weak self] albumImage in
               
                 self?.albumImagesPublishSubj.onNext(albumImage)

             }, onError: { error in
                 print(error.localizedDescription)
             }).disposed(by: disposeBag)

 
    
    }
        
        

    
    
    
    
}
