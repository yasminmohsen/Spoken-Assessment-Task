//
//  JsonConverter.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//


import Foundation

func jsonConverterToModel<T:Codable>(data :Data)-> T?{
 
    let jsonDecoder = JSONDecoder()
    
    do {
        
        let decodeObj = try jsonDecoder.decode(T.self, from: data)
         return decodeObj

    }
    
    catch{
        
        print(error.localizedDescription)
        
    }
    
    return nil
    
    
    
}
