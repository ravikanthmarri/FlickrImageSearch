//
//  NetworkingEndpointTests.swift
//  FlickrImageSearchTests
//
//  Created by Ravikanth on 27/02/2024.
//

import XCTest
@testable import FlickrImageSearch

final class NetworkingEndpointTests: XCTestCase {

    func test_with_search_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.search(text: "Cat", page: 1)
        
        XCTAssertEqual(endpoint.host, "flickr.com", "The host should be flickr.com")
        XCTAssertEqual(endpoint.path, "/services/rest", "The path should be /services/rest")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        XCTAssertEqual(endpoint.queryItems, ["method": "flickr.photos.search",
                                             "text": "Cat",
                                             "page": "1",
                                             "content_types": "0",
                                             "per_page": "8"], "The query items are not as expected")

    }


}
 
