//
//  ImageSearchViewModelSuccessTests.swift
//  FlickrImageSearchTests
//
//  Created by Ravikanth on 27/02/2024.
//

import XCTest
@testable import FlickrImageSearch

final class ImageSearchViewModelSuccessTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerImpl!
    private var vm: ImageSearchViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerSearchResponseSuccessMock()
        vm = ImageSearchViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }

    func test_with_successful_response_photos_array_is_set() async throws {
       
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        await vm.fetchPhotos(query: "Cat")
        XCTAssertEqual(vm.allPhotos.count, 8, "There should be 8 photos within our data array")
        XCTAssertEqual(vm.photoIds.count, 8, "There should be 8 photoIds within photoIds array")

    }
    
    func test_with_successful_paginated_response_photos_array_is_set() async throws {
        
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")

        defer {
            XCTAssertFalse(vm.isFetching, "The view model shouldn't be fetching any data")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        
        await vm.fetchPhotos(query: "Cat")
        
        XCTAssertEqual(vm.allPhotos.count, 8, "There should be  8 photos within our data array")
        XCTAssertEqual(vm.photoIds.count, 8, "There should be 8 photoIds within photoIds array")

        await vm.fetchNextSetOfPhotos()
        
        XCTAssertEqual(vm.allPhotos.count, 16, "There should be  16 photos within our data array")
        XCTAssertEqual(vm.photoIds.count, 16, "There should be 16 photoIds within photoIds array")

                
        XCTAssertEqual(vm.page, 2, "The page should be 2")
    }

    func test_with_reset_called_values_is_reset() async throws {

        defer {
            XCTAssertEqual(vm.allPhotos.count, 8, "There should be 8 photos within our data array")
            XCTAssertEqual(vm.page, 1, "The page should be 1")
            XCTAssertEqual(vm.totalPages, 11472, "The total pages should be 11472")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        }
        
        await vm.fetchPhotos(query: "Cat")

        XCTAssertEqual(vm.allPhotos.count, 8, "There should be  8 photos within our data array")
        XCTAssertEqual(vm.photoIds.count, 8, "There should be 8 photoIds within photoIds array")


        await vm.fetchNextSetOfPhotos()
        
        XCTAssertEqual(vm.allPhotos.count, 16, "There should be  16 photos within our data array")
        XCTAssertEqual(vm.photoIds.count, 16, "There should be 16 photoIds within photoIds array")
                
        XCTAssertEqual(vm.page, 2, "The page should be 2")

        await vm.fetchPhotos(query: "Cat")
    }
    
    func test_with_last_user_func_returns_true() async {

        await vm.fetchPhotos(query: "Cat")

        let photosData = try! StaticJSONMapper.decode(file: "ImagesStaticData", type: PhotosSearchResponse.self)
        
        let hasReachedEnd = vm.hasReachedEnd(photo: photosData.photos.photo.last!)
        
        XCTAssertTrue(hasReachedEnd, "The last user should match")
    }
    
    func test_adding_search_history() {
        
        vm.addToSearchHistsory(query: "Cat")
        vm.addToSearchHistsory(query: "Forest")
        vm.addToSearchHistsory(query: "Beach")

        let searchHistory = vm.getSearchSuggetions()
        
        XCTAssertTrue(searchHistory.contains("Cat"), "The search history should contain Cat")
        XCTAssertTrue(searchHistory.contains("Forest"), "The search history should contain Forest")
        XCTAssertTrue(searchHistory.contains("Beach"), "The search history should contain Beach")
    }
    
    func test_with_successful_response_with_duplicate_photo_ids() async throws {
       
        await vm.fetchPhotos(query: "Cat")
        XCTAssertEqual(vm.allPhotos.count, 8, "There should be 8 photos within our data array")
        
        XCTAssertEqual(vm.photoIds.count, 8, "There should be 8 photoIds within photoIds array")

    }
}
