//
//  NetworkingManager.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 23/02/2024.
//

import Foundation

protocol NetworkingManagerImpl {
    
    func request<T: Codable>(session: URLSession,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T
}

final class NetworkingManager: NetworkingManagerImpl {
    
    static let shared = NetworkingManager()
    
    private init() { }
     
    func request<T: Codable>(session: URLSession = .shared,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
                
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (data, response) = try await session .data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        return result
     }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkingManager.NetworkingError: Equatable {
    
    static func == (lhs: NetworkingManager.NetworkingError, rhs: NetworkingManager.NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidUrl, .invalidUrl):
            return true
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case (.invalidData, .invalidData):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}

extension NetworkingManager.NetworkingError {
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL isn't valid"
        case .custom(let error):
            return "Something went wrong \(error.localizedDescription)"
        case .invalidStatusCode:
            return "Invalid status code received from server"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        }
    }
}



private extension NetworkingManager {
    
    func buildRequest(from url: URL,
                      methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST:
            request.httpMethod = "POST"
        }
        return request
    }
}
