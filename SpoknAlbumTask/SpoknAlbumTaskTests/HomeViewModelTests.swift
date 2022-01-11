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
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockingNetworkManager = MockingNetworkManager(shouldReturnError: false)
        dispose = DisposeBag()
        homeViewModel = HomeViewModel(apiService: mockingNetworkManager!)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockingNetworkManager = nil
        dispose = nil
        homeViewModel = nil
    }
    
    
    
    
    func testSucessfullFtechingUsers(){
        homeViewModel?
            .apiService.getUsers()
            .subscribe(onNext: { user in
                XCTAssertNotNil(user)
            }, onError: { error in
                XCTFail()
            }).disposed(by:dispose!)
    }
    
    
    
    func testFailfullFtechingUser(){
        mockingNetworkManager?.shouldReturnError = true
        
        homeViewModel?
            .apiService.getUsers()
            .subscribe(onNext: { album in
                XCTFail()
            }, onError: { error in
                XCTAssertNotNil(error)
            }).disposed(by:dispose!)
    }
    
    
    
    
    func testSucessfullFtechingAlbumData(){
        homeViewModel?
            .apiService
            .getAlbums(userId: 0)
            .subscribe(onNext: { album in
                XCTAssertEqual(album.count, 10)
            }, onError: { error in
                XCTFail()
            }).disposed(by:dispose!)
    }
    
    
    
    func testFailfullFtechingAlbumData(){
        mockingNetworkManager?.shouldReturnError = true
        
        homeViewModel?
            .apiService.getAlbums(userId: 0)
            .subscribe(onNext: { album in
                XCTFail()
            }, onError: { error in
                print(error)
                XCTAssertNotNil(error)
            }).disposed(by:dispose!)
    }
    
    
    
    func testSucessfullFtechingImages(){
        
        homeViewModel?
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
        homeViewModel?
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

