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
    
    
    // MARK: - fetchUsers Function Implementation :
    
    func fetchUsers() -> Observable<User> {
        return provider
            .rx
            .request(.user)
            .filterSuccessfulStatusCodes()
            .map([User].self).map({return $0.randomElement()!})
            .asObservable()
    }
    
    // MARK: - fetchAlbums Function Implementation :
    
    func fetchAlbums(userId:Int) -> Observable<[Album]> {
        return provider
            .rx
            .request(.albums(userId: userId))
            .filterSuccessfulStatusCodes()
            .map([Album].self)
            .asObservable()
    }
    
    
    // MARK: - fetchPhotos Function Implementation :
    
    func fetchPhotos(albumId: Int) -> Observable<[AlbumImage]> {
        return provider
            .rx
            .request(.images(albumId: albumId))
            .filterSuccessfulStatusCodes()
            .map([AlbumImage].self)
            .asObservable()
    }
    
}



