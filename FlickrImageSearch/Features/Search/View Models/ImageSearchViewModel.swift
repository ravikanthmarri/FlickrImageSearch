//
//  ImageSearchViewModel.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 24/02/2024.
//

import Foundation

@Observable
final class ImageSearchViewModel {
    
    private(set) var photos: [Photo] = []
    private(set) var error: NetworkingManager.NetworkingError?
    private(set) var isLoading = false
    var hasError = false
    
    func fetchPhotos() async {
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            let response = try await NetworkingManager.shared.request(.search(text: "Forest"), type: PhotosSearchResponse.self)
            self.photos = response.photos.photo
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}
