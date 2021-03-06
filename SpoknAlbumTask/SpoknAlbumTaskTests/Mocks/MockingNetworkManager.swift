//
//  MockingNetworkManager.swift
//  SpoknAlbumTaskTests
//
//  Created by Yasmin Mohsen on 11/01/2022.
//

import Foundation
import XCTest
import RxMoya
import RxSwift
import Moya
@testable import SpoknAlbumTask

class MockingNetworkManager :ApiServiceProtocol {
    
    //MARK: - Properties
    var shouldReturnError :Bool?  /// Used To Test failure Cases
    var  provider =  MoyaProvider<ApiServices>(stubClosure: MoyaProvider.immediatelyStub)
    let dispose = DisposeBag()
    
    
    //MARK: - override init to set the value of shouldReturnError :
    init(shouldReturnError:Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    
    //MARK: - Functions :
    func fetchUsers() -> Observable<User> {
        
        if(shouldReturnError!){
            ChangeToErrorReqProvider()
            return provider
                .rx
                .request(.user)
                .filterSuccessfulStatusCodes()
                .map([User].self).map({return $0[0]})
                .asObservable()
        }
        else{
            return provider
                .rx
                .request(.user)
                .filterSuccessfulStatusCodes()
                .map([User].self).map({return $0[0]})
                .asObservable()
        }
        
    }
    
    
    func fetchAlbums(userId: Int) -> Observable<[Album]> {
        
        if(shouldReturnError!){
            ChangeToErrorReqProvider()
            return provider
                .rx
                .request(.albums(userId: userId))
                .filterSuccessfulStatusCodes()
                .map([Album].self)
                .asObservable()
            
        }
        
        else{
            return provider
                .rx
                .request(.albums(userId: userId))
                .filterSuccessfulStatusCodes()
                .map([Album].self)
                .asObservable()
        }
        
    }
    
    
    
    func fetchPhotos(albumId: Int) -> Observable<[AlbumImage]> {
        
        if(shouldReturnError!){
            ChangeToErrorReqProvider()
            return provider
                .rx
                .request(.images(albumId: 2))
                .filterSuccessfulStatusCodes()
                .map([AlbumImage].self)
                .asObservable()
        }
        else{
            return provider
                .rx
                .request(.images(albumId: 1))
                .filterSuccessfulStatusCodes()
                .map([AlbumImage].self)
                .asObservable()
        }
        
    }
    
}




extension MockingNetworkManager {
    
    /// To create a custom endPoint with response code = 404 to test failure
    private func ChangeToErrorReqProvider(){
        
        let customEndPoint = {(target: ApiServices)->Endpoint in
            return Endpoint(url: ((URL(target: target).absoluteString)),
                            sampleResponseClosure: { .networkResponse(404, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        provider = MoyaProvider<ApiServices>(endpointClosure: customEndPoint, stubClosure: MoyaProvider.immediatelyStub)
    }
    
}
