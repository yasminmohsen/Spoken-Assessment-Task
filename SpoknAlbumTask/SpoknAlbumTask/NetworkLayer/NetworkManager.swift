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
    
    func fetchUser() -> Observable<User> {
        
        return Observable.create { [weak self]observer -> Disposable in
       
            self?.provider.request(.user) { result in
                
                switch result{
                case .success(let response):
            
                    guard let usersArray:[User] = jsonConverterToModel(data: response.data)  else{return}
                
                    guard let user = usersArray.randomElement() else{return}
                    observer.onNext(user)
            
                case .failure(let error):
                    observer.onError(error)
                }
                
            }
            
            return Disposables.create()
        }
        
    }
    
    func fetchAlbum(userId: Int) -> Observable<[Album]> {

        return Observable.create { [weak self]observer -> Disposable in
       
            self?.provider.request(.albums(userId: userId)) { result in
                
                switch result{
                case .success(let response):
            
                    guard let usersAlbum:[Album] = jsonConverterToModel(data: response.data)  else{return}
                
                    observer.onNext(usersAlbum)
                    
                case .failure(let error):
                    observer.onError(error)
                }
                
            }
            
            return Disposables.create()
        }
        
        
        
    }
//
//    func fetchPhotos(albumId: Int) -> Observable<[AlbumImage]> {
//
//    }
    
    
}
