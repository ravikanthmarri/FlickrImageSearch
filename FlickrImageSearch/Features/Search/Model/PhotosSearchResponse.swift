//
//  PhotosSearchResponse.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 23/02/2024.
//

import Foundation

// MARK :- PhotosSearchResponse
struct PhotosSearchResponse: Codable, Equatable {
    let photos: SearchResult
    
}

// MARK :- SearchResult
struct SearchResult: Codable, Equatable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}
