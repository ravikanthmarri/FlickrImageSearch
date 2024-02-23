//
//  PhotosSearchResponse.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 23/02/2024.
//

import Foundation

// MARK :- PhotosSearchResponse
struct PhotosSearchResponse: Codable {
    let photos: SearchResult
    
}

// MARK :- SearchResult
struct SearchResult: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}
