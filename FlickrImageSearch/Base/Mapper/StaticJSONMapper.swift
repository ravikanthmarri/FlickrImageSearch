//
//  StaticJSONMapper.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 23/02/2024.
//

import Foundation

struct StaticJSONMapper {
    
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        guard let path = Bundle.main.path(forResource: file , ofType: "json"),
                let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContrnts
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContrnts
    }
}
