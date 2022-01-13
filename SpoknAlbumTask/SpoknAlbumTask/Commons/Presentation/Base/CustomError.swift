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
    
    static func localizedError(error : Error) -> String
    {
        guard let error = error as? MoyaError else {
            
            return  "Something went wrong"
        }
        
            
            switch error.response?.statusCode {
            case 500: // server error
                return "Server Error , Please Try Again"
            case 401: // unauthorized
                return "Unauthorized User"
            default: // using error.response in defult case but in real case we need descriptive message from api (backend)
                if(error.errorDescription == "URLSessionTask failed with error: The Internet connection appears to be offline.") {
                    return "The Internet connection appears to be offline"
                }
                else{
                    //debugPrint(error.response?.description ?? "Error")
                    return  "Something went wrong"
                }
                
               
            }
        }
        
        
    }
    
    
    

