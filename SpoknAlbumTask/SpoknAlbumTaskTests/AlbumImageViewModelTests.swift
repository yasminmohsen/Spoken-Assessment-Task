//
//  AlbumImageViewModelTests.swift
//  SpoknAlbumTaskTests
//
//  Created by Yasmin Mohsen on 12/01/2022.
//

import XCTest
import RxSwift
import Moya
import RxMoya
@testable import SpoknAlbumTask
class AlbumImageViewModelTests: XCTestCase {

    var albumImageViewModel :AlbumImageViewModel?
    var mockingNetworkManager :MockingNetworkManager?
    var dispose:DisposeBag?

    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockingNetworkManager = MockingNetworkManager(shouldReturnError: false)
        dispose = DisposeBag()
        albumImageViewModel = AlbumImageViewModel(apiService: mockingNetworkManager!)
        
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        mockingNetworkManager = nil
        dispose = nil
        albumImageViewModel = nil
        
    }
    
    //MARK:- Testing FetchingImages Functions :
    
    func testSucessfullFtechingImages(){
        
        albumImageViewModel?
            .apiService
            .fetchPhotos(albumId: 0)
            .subscribe(onNext: { img in
                XCTAssertEqual(img.count, 2)
            }, onError: { error in
                print(error)
                XCTFail()
            }).disposed(by:dispose!)
        
    }
    
    
    func testFailfullFtechingImages(){
        mockingNetworkManager?.shouldReturnError = true
        
        albumImageViewModel?
            .apiService
            .fetchPhotos(albumId: 0)
            .subscribe(onNext: { img in
                XCTFail()
            }, onError: { error in
                print(error)
                XCTAssertNotNil(error)
            }).disposed(by:dispose!)
        
    }
    }


