//
//  PhotoModel.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation

struct AlbumImage: Codable {
    
    let albumID, imageId: Int
    let imageTitle,imageURL, thumbnailURL: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case imageId = "id"
        case imageTitle = "title"
        case imageURL = "url"
        case thumbnailURL = "thumbnailUrl"
    }
}
