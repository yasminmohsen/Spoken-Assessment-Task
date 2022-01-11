//
//  NetworkManager.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import Moya
import RxSwift
import RxMoya
class NetworkManager: ApiServiceProtocol {

 var provider : MoyaProvider<ApiServices> = MoyaProvider<ApiServices>()
    
    
    // MARK: - getUsers Function Implementation
    func getUsers() -> Observable<User> {
    return provider.rx.request(.user).filterSuccessfulStatusCodes().map([User].self).map({return $0.randomElement()!}).asObservable()
    

}
    
    // MARK: - getAlbums Function Implementation
    func getAlbums(userId:Int) -> Observable<[Album]> {
        return provider.rx.request(.albums(userId: userId)).filterSuccessfulStatusCodes().map([Album].self).asObservable()
    

}
    
    
    // MARK: - fetchPhotos Function Implementation
    
    func fetchPhotos(albumId: Int) -> Observable<[AlbumImage]> {
        return provider.rx.request(.images(albumId: albumId)).filterSuccessfulStatusCodes().map([AlbumImage].self).asObservable()
   
        
    }
    
    
    
  
    
}
    
  
/*
 
 func fetchHomeData() -> Observable<HomeModel> {
     
     return Observable.create { [weak self]observer -> Disposable in
         
         self?.provider.request(.user) { result in
             
             switch result{
             case .success(let response):
                 
                 guard let usersArray:[User] = jsonConverterToModel(data: response.data)  else{return}
                 
                 guard let user = usersArray.randomElement() else{return}
                 
                 // MARK: - fetch albums using random userID :-
                 
                 self?.provider.request(.albums(userId:user.id)) { result in
                     
                     switch result{
                     case .success(let response):
                         
                         guard let usersAlbum:[Album] = jsonConverterToModel(data: response.data)  else{return}
                         
                         let userFullData = HomeModel(user: user, albums: usersAlbum)
                         
                         observer.onNext(userFullData)
                         
                     case .failure(let error):
                         observer.onError(error)
                     }

}
 
                 }
                 
             case .failure(let error):
                 observer.onError(error)
             }
             
         }
         
         return Disposables.create()
     }
     
 }
 
 
 
 
 
 
 */
