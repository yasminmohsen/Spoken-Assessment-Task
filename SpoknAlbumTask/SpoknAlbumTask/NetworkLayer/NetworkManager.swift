//
//  NetworkManager.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import Moya
import RxSwift
class NetworkManager: ApiServiceProtocol {
   
    var provider = MoyaProvider<ApiServices>()
    
    
    
    // MARK: -Function Implementation
    
    func fetchHomeData() -> Observable<HomeModel> {
        
        return Observable.create { [weak self]observer -> Disposable in
            
            self?.provider.request(.user) { result in
                
                switch result{
                case .success(let response):
                    
                    guard let usersArray:[User] = jsonConverterToModel(data: response.data)  else{return}
                    
                    guard let user = usersArray.randomElement() else{return}
                    
                    self?.provider.request(.albums(userId:user.id)) { result in
                        
                        switch result{
                        case .success(let response):
                            
                            guard let usersAlbum:[Album] = jsonConverterToModel(data: response.data)  else{return}
                            
                            var userFullData = HomeModel(user: user, albums: usersAlbum)
                            
                            
                            observer.onNext(userFullData)
                            
                            
                        case .failure(let error):
                            observer.onError(error)
                        }
                        
                    }
                    
                    
                    
                    
                case .failure(let error):
                    observer.onError(error)
                }
                
            }
            
            return Disposables.create()
        }
        
    }
    
    
    
    
    
    func fetchPhotos(albumId: Int) -> Observable<[AlbumImage]> {
         
        return Observable.create {[weak self] observer -> Disposable in
            
            self?.provider.request(.images(albumId: albumId)) { result in
                switch result {
                
                case .success(let response):
                    
                    guard let imagesAlbum:[AlbumImage] = jsonConverterToModel(data: response.data)  else{return}
                    observer.onNext(imagesAlbum)
                    
                case .failure(let error):
                    observer.onError(error)
                
                
                }
                        
            }
       
            return Disposables.create()
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
