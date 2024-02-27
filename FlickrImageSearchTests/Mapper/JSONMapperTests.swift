//
//  JSONMapperTests.swift
//  FlickrImageSearchTests
//
//  Created by Ravikanth on 27/02/2024.
//

import Foundation
import XCTest
@testable import FlickrImageSearch

class JSONMapperTests: XCTestCase {
    
    func test_with_valid_json_successfully_decodes() {
        
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "ImagesStaticData", type: PhotosSearchResponse.self), "Mapper shouldn't throw an error")
        
        let searchResponse = try! StaticJSONMapper.decode(file: "ImagesStaticData", type: PhotosSearchResponse.self)
        XCTAssertNotNil(searchResponse, "User response shouldn't be nil")
             
        XCTAssertEqual(searchResponse.photos.page, 1, "Page number should be 1")
        XCTAssertEqual(searchResponse.photos.perpage, 8, "Page number should be 8")
        XCTAssertEqual(searchResponse.photos.total, 91772, "Total number of photos should be 91772")
        XCTAssertEqual(searchResponse.photos.pages, 11472, "Total pages should be 11472")
        XCTAssertEqual(searchResponse.photos.photo.count, 8, "The total number of photos should be 8")
        
        
        XCTAssertEqual(searchResponse.photos.photo[0].id, "53555147656", "The id should be 53555147656")
        XCTAssertEqual(searchResponse.photos.photo[0].owner, "49207239@N07", "The owner should be 49207239@N07")
        XCTAssertEqual(searchResponse.photos.photo[0].secret, "56b4667ba7", "The secret should be 56b4667ba7")
        XCTAssertEqual(searchResponse.photos.photo[0].server, "65535", "The server should be 65535")
        XCTAssertEqual(searchResponse.photos.photo[0].title, "Territory marking", "The title should be Territory marking")
        XCTAssertEqual(searchResponse.photos.photo[0].url, "https://live.staticflickr.com/65535/53555147656_56b4667ba7.jpg", "The url should be https://live.staticflickr.com/65535/53555147656_56b4667ba7.jpg")

        
        XCTAssertEqual(searchResponse.photos.photo[1].id, "53555849645", "The id should be 53555849645")
        XCTAssertEqual(searchResponse.photos.photo[1].owner, "76561972@N07", "The owner should be 76561972@N07")
        XCTAssertEqual(searchResponse.photos.photo[1].secret, "c66a7d4bff", "The secret should be c66a7d4bff")
        XCTAssertEqual(searchResponse.photos.photo[1].server, "65535", "The server should be 65535")
        XCTAssertEqual(searchResponse.photos.photo[1].title, "DSC_8375_LR", "The title should be DSC_8375_LR")
        XCTAssertEqual(searchResponse.photos.photo[1].url, "https://live.staticflickr.com/65535/53555849645_c66a7d4bff.jpg", "The url should be https://live.staticflickr.com/65535/53555849645_c66a7d4bff.jpg")
        
                
        
        XCTAssertEqual(searchResponse.photos.photo[2].id, "53555402366", "The id should be 53555402366")
        XCTAssertEqual(searchResponse.photos.photo[2].owner, "76561972@N07", "The owner should be 76561972@N07")
        XCTAssertEqual(searchResponse.photos.photo[2].secret, "91a81450a2", "The secret should be 91a81450a2")
        XCTAssertEqual(searchResponse.photos.photo[2].server, "65535", "The server should be 65535")
        XCTAssertEqual(searchResponse.photos.photo[2].title, "DSC_8609_LR", "The title should be DSC_8609_LR")
        XCTAssertEqual(searchResponse.photos.photo[2].url, "https://live.staticflickr.com/65535/53555402366_91a81450a2.jpg", "The url should be https://live.staticflickr.com/65535/53555402366_91a81450a2.jpg")
    
    }
    
    func test_with_missing_file_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: PhotosSearchResponse.self), "An error should be thrown")
        do {
            _ = try StaticJSONMapper.decode(file: "", type: PhotosSearchResponse.self)
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get contents error")
        }
    }
    
    func test_with_invalid_file_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "abcd", type: PhotosSearchResponse.self), "An error should be thrown")
        do {
            _ = try StaticJSONMapper.decode(file: "abcd", type: PhotosSearchResponse.self)
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get contents error")
        }
    }
    
    func test_with_invalid_json_error_thrown() {
        
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "ImagesStaticData", type: SearchResult.self), "An error should be thrown")
        
        do {
            _ = try StaticJSONMapper.decode(file: "ImagesStaticData", type: SearchResult.self)
        } catch {
            if error is StaticJSONMapper.MappingError {
                XCTFail("Got the wrong type of error, expecting a system decoding error")
            }
        }
    }
}
