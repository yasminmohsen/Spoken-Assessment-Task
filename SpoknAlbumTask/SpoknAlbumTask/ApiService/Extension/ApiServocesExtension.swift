//
//  ApiServocesExtension.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation
import Moya

// MARK: - Add Moya Configurations

extension ApiServices:TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .user:
            return "/users"
        case .albums:
            return "/albums"
        case .images:
            return "/photos"
            
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .user:
            return .requestPlain
            
        case .albums( let userId) :
            return .requestParameters(
                parameters: [
                    "userId": String(userId)
                ], encoding: URLEncoding.default)
            
        case .images(let albumId):
            return .requestParameters(
                parameters: [
                    "albumId": String(albumId)
                ], encoding: URLEncoding.default)
            
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

