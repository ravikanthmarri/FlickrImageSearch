//
//  ImageSearchView.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 23/02/2024.
//

import SwiftUI

struct ImageSearchView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @State private var photos: [Photo] = []
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    
                    background
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(photos) { photo in
                                ImageCellView(proxy: proxy, photo: photo)
                            }
                        }
                        .padding([.leading, .trailing])
                    }
                }
                .navigationTitle("Image Search")
                .onAppear {
                    do {
                        let results = try StaticJSONMapper.decode(file: "ImagesStaticData", type: PhotosSearchResponse.self)
                        photos = results.photos.photo
                    } catch {
                        // TODO: Handle any errors
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    ImageSearchView()
}

private extension ImageSearchView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea()
    }
    
}
