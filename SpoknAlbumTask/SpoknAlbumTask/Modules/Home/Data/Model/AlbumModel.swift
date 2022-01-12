//
//  AlbumModel.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation

struct Album: Codable {
    let userID, albumID: Int
    let albumTitle: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case albumID = "id"
        case albumTitle = "title"
    }
}
