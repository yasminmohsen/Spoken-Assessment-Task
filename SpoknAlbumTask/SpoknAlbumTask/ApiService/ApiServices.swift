//
//  ApiServices.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 09/01/2022.
//

import Foundation

enum ApiServices {
    case user
    case albums(userId:Int)
    case images (albumId:Int)
}
