//
//  HomeViewModelTests.swift
//  SpoknAlbumTaskTests
//
//  Created by Yasmin Mohsen on 11/01/2022.
//

import XCTest
import RxSwift
import Moya
import RxMoya
@testable import SpoknAlbumTask
class HomeViewModelTests: XCTestCase {
    
    var homeViewModel :HomeViewModel?
    var mockingNetworkManager :MockingNetworkManager?
    var dispose:DisposeBag?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockingNetworkManager = MockingNetworkManager(shouldReturnError: false)
        dispose = DisposeBag()
        homeViewModel = HomeViewModel(apiService: mockingNetworkManager!)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        mockingNetworkManager = nil
        dispose = nil
        homeViewModel = nil
    }
    
    //MARK:- Testing FetchingUser Functions :
    
    func testSucessfullFtechingUsers(){       /// Testing SucessfullFtechingUsers Case
        homeViewModel?
            .apiService.fetchUsers()
            .subscribe(onNext: { user in
                XCTAssertNotNil(user)
            }, onError: { error in
                XCTFail()
            }).disposed(by:dispose!)
    }
    
    
    func testFailureFtechingUser(){        /// Testing FailureFtechingUsers Case
        mockingNetworkManager?.shouldReturnError = true
        
        homeViewModel?
            .apiService.fetchUsers()
            .subscribe(onNext: { album in
                XCTFail()
            }, onError: { error in
                XCTAssertNotNil(error)
            }).disposed(by:dispose!)
    }
    
    //MARK:- Testing FetchingAlbum Functions :
    
    func testSucessfullFtechingAlbumData(){      /// Testing SucessfullFtechingAlbumData Case
        homeViewModel?
            .apiService
            .fetchAlbums(userId: 0)
            .subscribe(onNext: { album in
                XCTAssertEqual(album.count, 10)
            }, onError: { error in
                XCTFail()
            }).disposed(by:dispose!)
    }
    
    
    
    func testFailureFtechingAlbumData(){           /// Testing FailureFtechingAlbumData Case
        mockingNetworkManager?.shouldReturnError = true
        
        homeViewModel?
            .apiService.fetchAlbums(userId: 0)
            .subscribe(onNext: { album in
                XCTFail()
            }, onError: { error in
                print(error)
                XCTAssertNotNil(error)
            }).disposed(by:dispose!)
    }
    
  
}

