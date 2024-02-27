//
//  ImageSearchViewModelFailueTests.swift
//  FlickrImageSearchTests
//
//  Created by Ravikanth on 27/02/2024.
//

import XCTest
@testable import FlickrImageSearch

final class ImageSearchViewModelFailueTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerImpl!
    private var vm: ImageSearchViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerSearchResponseFailureMock()
        vm = ImageSearchViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }

    func test_with_unsuccessful_response_error_is_handled() async {

        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        
        await vm.fetchPhotos(query: "Cat")
        
        XCTAssertTrue(vm.hasError, "The view model should have an error")
        XCTAssertNotNil(vm.error, "The view model error should be set")
    }

}
