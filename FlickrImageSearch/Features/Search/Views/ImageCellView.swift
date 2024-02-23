//
//  ImageCellView.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 23/02/2024.
//

import SwiftUI

struct ImageCellView: View {
    
    let proxy: GeometryProxy
    let photo: Photo
    
    var body: some View {
        VStack(spacing: 0) {

            imagePreview
            title
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Theme.text.opacity(0.1),
                radius: 2,
                x: 1 ,
                y: 1)
    }
}

#Preview {
    GeometryReader { proxy in
        ImageCellView(proxy: proxy, photo: Photo.previewProduct)
            .frame(width: 200)
    }
}

private extension ImageCellView {
    
    @ViewBuilder
    var imagePreview: some View {
        let dimension = (proxy.size.width - 48)/2
        AsyncImage(url: .init(string: photo.url)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: dimension,height: dimension)
                .clipped()
        } placeholder: {
            ProgressView()
        }
    }
    
    @ViewBuilder
    var title: some View {
        HStack {
            Text("\(photo.title)")
                .foregroundStyle(Theme.text)
                .lineLimit(2)
            Spacer()
        }
        .frame(height: 50)
        .padding(8)
        .background(Theme.cellBackground)
    }
}
