//
//  NetworkingManagerSearchResponseSuccessMock.swift
//  FlickrImageSearchTests
//
//  Created by Ravikanth on 27/02/2024.
//

#if DEBUG
import Foundation
@testable import FlickrImageSearch

class NetworkingManagerSearchResponseSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Codable {
        var pageNumber = 1
        switch endpoint {
        case .search(let query, let page):
            pageNumber = page
        case .getInfo(photoId: let photoId):
            break
        case .setTags(photoId: let photoId, tags: let tags):
            break
        }
        if pageNumber == 1 {
            return try StaticJSONMapper.decode(file: "ImagesStaticData", type: PhotosSearchResponse.self) as! T
        } else {
            return try StaticJSONMapper.decode(file: "ImagesStaticDataNextPage", type: PhotosSearchResponse.self) as! T
        }
    }
}
#endif
 
