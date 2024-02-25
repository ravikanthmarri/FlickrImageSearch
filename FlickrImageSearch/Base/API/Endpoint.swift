//
//  Endpoint.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 25/02/2024.
//

import Foundation

let apiKey = "c61b99b69046e37211dd95aa85e7b5c5"

enum Endpoint {
    case search(text: String)
    // Scalable for future implementation to implement Image details, set tags features
    case getInfo(photoId: Int)
    case setTags(photoId: Int, tags: String)
}

extension Endpoint {
    enum MethodType {
        case GET
        case POST
    }
}

extension Endpoint {
    
    var host: String { "flickr.com" }
    var path: String { "/services/rest" }
    
    var methodType: MethodType {
        switch self {
        case .search,
             .getInfo:
            return .GET
        case .setTags:
            return .POST
        }
    }
        
    var queryItems: [String: String]? {
        switch self {
        case .search(let text):
            return ["method": "flickr.photos.search",
                    "text": "\(text)",
                    "content_types": "0",
                    "per_page":"8"]
            
        // Scalable for future implementation to get Photo details, set tags for photo features
        case .getInfo(let photoId):
            return ["method": "flickr.photos.getInfo",
                    "photo_id":"\(photoId)"]
        case .setTags(let photoId, let tags):
            return ["method": "flickr.photos.setTags",
                    "photo_id":"\(photoId)",
                    "tags":"\(tags)"]
        }
    }
}

extension Endpoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        
        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        requestQueryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        requestQueryItems.append(URLQueryItem(name: "format", value: "json"))
        requestQueryItems.append(URLQueryItem(name: "nojsoncallback", value: "1"))

        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}
