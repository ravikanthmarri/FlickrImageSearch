//
//  ImageSearchViewModel.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 24/02/2024.
//

import Foundation

@Observable
final class ImageSearchViewModel {
    
    private(set) var allPhotos: [Photo] = []
    private(set) var photoIds = [String]()
    private(set) var error: NetworkingManager.NetworkingError?
    private(set) var viewState: ViewState?
    var hasError = false
    
    var searchString: String = "Forest"
    private var page = 1
    private var totalPages: Int?
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }

    func fetchPhotos() async {
        viewState = .loading
        defer { viewState = .finished }

        do {
            let response = try await NetworkingManager.shared.request(.search(text: searchString, page: page), type: PhotosSearchResponse.self)
            self.totalPages = response.photos.pages
            appendUniquePhotos(photos: response.photos.photo)
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func fetchNextSetOfPhotos() async {
        
        guard page != totalPages else { 
            return
        }
        
        viewState = .fetching
        defer {
            viewState = .finished
        }
        
        page += 1 
    
        do {
            let response = try await NetworkingManager.shared.request(.search(text: searchString, page: page), type: PhotosSearchResponse.self)
            self.totalPages = response.photos.pages
            appendUniquePhotos(photos: response.photos.photo)
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func hasReachedEnd(photo: Photo) -> Bool {
        photoIds.last == photo.id
    }
    

    ///
    ///  Flicr service response is returning duplicate photos, because of this ForEach loop behaviour is unpredictable.
    ///  So appending only unique photos ...to keep the list elements unique...
    func appendUniquePhotos(photos: [Photo]) {
        for photo in photos {
            if !photoIds.contains(photo.id) {
                photoIds.append(photo.id)
                allPhotos.append(photo)
            }
        }
    }
}

extension ImageSearchViewModel {
    enum ViewState {
        case loading
        case fetching
        case finished
    }
}

extension ImageSearchViewModel {
    func reset() {
        if viewState == .finished {
            allPhotos.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
