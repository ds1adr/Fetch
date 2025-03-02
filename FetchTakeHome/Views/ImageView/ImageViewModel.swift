//
//  ImageViewModel.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import UIKit

enum ImageConstants {
    static let thumbnailSize: CGFloat = 50
}

//@Observable (from iOS 17)
class ImageViewModel: ObservableObject {
    let urlString: String
    @Published var uiImage: UIImage?
    
    init(urlString: String) {
        self.urlString = urlString
        Task { @MainActor in
            uiImage = await ImageRepository.shared.getImage(urlString: urlString)
        }
    }
}
