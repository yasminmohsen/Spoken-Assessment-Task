//
//  ApiServicesProtocol.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import RxSwift
import Moya

protocol ApiServiceProtocol {
    
    var provider :MoyaProvider<ApiServices> {get}
    
    // MARK: - Functions
    
    func fetchHomeData()->Observable<HomeModel>
    func fetchPhotos(albumId:Int)->Observable<[AlbumImage]>
    
    
}
