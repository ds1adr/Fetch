//
//  ImageView.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var viewModel: ImageViewModel
    
    var body: some View {
        if let uiImage = viewModel.uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: ImageConstants.thumbnailSize,
                       height: ImageConstants.thumbnailSize)
                .clipShape(.rect(cornerRadius: 6))
        } else {
            // Place holder
            Image(systemName: "fork.knife")
                .resizable()
                .frame(width: ImageConstants.thumbnailSize,
                       height: ImageConstants.thumbnailSize)
        }
    }
}

#Preview {
    ImageView(viewModel: ImageViewModel(urlString: "test"))
}
