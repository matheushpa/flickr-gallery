//
//  Flickr_GalleryTests.swift
//  Flickr GalleryTests
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import XCTest
@testable import Flickr_Gallery

class Flickr_GalleryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPhotoSearchByTermVM() {
        let viewModel = SearchViewModel()
        viewModel.getPhotosByTerm(term: "kitten", page: 1)
    }

    func testPhotoSizeVM() {
        let viewModel = SearchViewModel()
        viewModel.getPhotoSizes(photoId: 31456463045)
    }

    func testPhotoSearchRequest() {
        SearchService.shared.fetchSearch(term: "kitten", page: 1) { (photos, error) in
            if let errorStatus = error as? URLError {
                print(errorStatus.errorCode)
            } else if let result = photos {
                print(result)
            }
        }
    }
    
    func testPhotoSizeRequest() {
        PhotosService.shared.fetchPhotoSize(photoId: 31456463045) { (photoSizes, error) in
            if let errorStatus = error as? URLError {
                print(errorStatus.errorCode)
            } else if let result = photoSizes {
                print(result)
            }
        }
    }
}
