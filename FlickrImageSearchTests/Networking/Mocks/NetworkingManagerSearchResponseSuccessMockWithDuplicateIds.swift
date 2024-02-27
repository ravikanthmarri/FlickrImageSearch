//
//  NetworkingManagerSearchResponseSuccessMockWithDuplicateIds.swift
//  FlickrImageSearchTests
//
//  Created by Ravikanth on 27/02/2024.
//

import Foundation

#if DEBUG
import Foundation
@testable import FlickrImageSearch

class NetworkingManagerSearchResponseSuccessMockWithDuplicateIds: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Codable {
        return try StaticJSONMapper.decode(file: "ImagesStaticDataWithDuplicateIDs", type: PhotosSearchResponse.self) as! T
    }
}
#endif
