//
//  NetworkingManagerSearchResponseFailureMock.swift
//  FlickrImageSearchTests
//
//  Created by Ravikanth on 27/02/2024.
//

import Foundation
@testable import FlickrImageSearch

class NetworkingManagerSearchResponseFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: FlickrImageSearch.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
}
