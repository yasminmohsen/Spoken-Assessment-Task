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
    
    // MARK: - Add Moya Configurations For Testing
    
    var sampleData: Data {
        
        switch self{
        case .user :
            return stubGenerator(fileName: "Users")
            
        case .albums :
            return stubGenerator(fileName: "Albums")
            
        case .images :
            return stubGenerator(fileName: "Images")
            
        }
        
    }
    
    
    private func stubGenerator(fileName:String) -> Data{
        
        guard let path = Bundle.main.path(forResource: "\(fileName)", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return Data()}
        return data
        
    }
    
}

