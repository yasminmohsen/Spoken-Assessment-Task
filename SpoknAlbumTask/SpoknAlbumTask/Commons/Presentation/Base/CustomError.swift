//
//  CusromError.swift
//  SpoknAlbumTask
//
//  Created by Yasmin Mohsen on 12/01/2022.
//

import Foundation
import Moya
import RxMoya

class CustomError {
    
    //MARK:- Create a static func to check api's error and return descriptive message :
    
    static func localizedError(error : Error) -> String {
        guard let error = error as? MoyaError else {
            debugPrint(error.localizedDescription)
            return  "Something went wrong"
        }
        
        switch error.response?.statusCode {
        case 500: return "Server Error , Please Try Again" // server error
        case 401:  return "Unauthorized User"// unauthorized
        default:
            if(error.errorDescription == "URLSessionTask failed with error: The Internet connection appears to be offline.") {
                return "The Internet connection appears to be offline"
            }
            else{
                debugPrint(error.response?.description ?? "Error")
                return  "Something went wrong"
            }
        }
    }
}




