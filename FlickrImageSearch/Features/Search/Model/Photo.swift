//
//  Photo.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 23/02/2024.
//

import Foundation

// MARK :- Photo
struct Photo: Codable, Identifiable {
    let id: String
    let owner: String
    let secret: String
    let server: String 
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    var url: String {
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
#if DEBUG
    static var previewProduct: Photo {
        let results = try! StaticJSONMapper.decode(file: "ImagesStaticData", type: PhotosSearchResponse.self)
        return results.photos.photo.first!
    }
#endif
}
