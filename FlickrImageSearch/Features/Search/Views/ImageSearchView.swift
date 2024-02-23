//
//  ImageSearchView.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 23/02/2024.
//

import SwiftUI

struct ImageSearchView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                background
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(1...10, id: \.self) { num in
                            ImageCellView()
                        }
                    }
                    .padding([.leading, .trailing])
                }
            }
            .navigationTitle("Image Search")
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
