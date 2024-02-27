//
//  ImageSearchViewModelSuccessTestsWithDuplicateIds.swift
//  FlickrImageSearchTests
//
//  Created by Ravikanth on 27/02/2024.
//

import XCTest
@testable import FlickrImageSearch

final class ImageSearchViewModelSuccessTestsWithDuplicateIds: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var vm: ImageSearchViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerSearchResponseSuccessMockWithDuplicateIds()
        vm = ImageSearchViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    
    func test_with_successful_response_with_duplicate_photos_ids_are_eliminated() async throws {
       
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        await vm.fetchPhotos(query: "Cat")
        XCTAssertEqual(vm.allPhotos.count, 6, "There should be 8 photos within our data array")
        XCTAssertEqual(vm.photoIds.count, 6, "There should be 8 photoIds within photoIds array")

    }
}
