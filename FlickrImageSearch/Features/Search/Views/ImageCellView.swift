//
//  ImageCellView.swift
//  FlickrImageSearch
//
//  Created by Ravikanth on 23/02/2024.
//

import SwiftUI

struct ImageCellView: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.red)
                .frame(height: 130)
            HStack {
                Text("<Title could be long>")
                    .foregroundStyle(Theme.text)
                Spacer()
            }
            .padding(8)
            .background(Theme.cellBackground)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Theme.text.opacity(0.1),
                radius: 2,
                x: 1 ,
                y: 1)
    }
}

#Preview {
    ImageCellView()
        .frame(width: 200)
}
