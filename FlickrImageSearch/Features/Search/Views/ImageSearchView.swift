//
//  ImageSearchView.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 23/02/2024.
//

import SwiftUI

struct ImageSearchView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @State private var vm = ImageSearchViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    
                    background
                    
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(vm.allPhotos) { photo in
                                    ImageCellView(proxy: proxy, photo: photo)
                                        .task {
                                            if vm.hasReachedEnd(photo: photo) {
                                                await vm.fetchNextSetOfPhotos()
                                            }
                                        }
                                }
                            }
                            .padding([.leading, .trailing])
                        }
                        .overlay(alignment: .bottom) {
                            if vm.isFetching {
                                ProgressView()
                            }
                        }
                    }
                }
                .navigationTitle("Image Search")
                .searchable(text: $vm.searchString)
                .task {
                    await vm.fetchPhotos()
                }
                .alert(isPresented: $vm.hasError, error: vm.error) {
                    Button("Retry") {
                        Task {
                            await vm.fetchPhotos()
                        }
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
