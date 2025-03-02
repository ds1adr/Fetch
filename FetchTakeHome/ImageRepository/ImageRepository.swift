//
//  ImageRepository.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import UIKit

protocol ImageDownloaderProtocol {
    func downloadImageData(urlString: String) async throws -> (Data, String)
}

final class ImageDownloader: ImageDownloaderProtocol {
    func downloadImageData(urlString: String) async throws -> (Data, String) {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let urlResponse = response as? HTTPURLResponse else {
                throw NetworkError.badResponse
            }
            
            guard (200...299).contains(urlResponse.statusCode) else {
                throw NetworkError.networkError(statusCode: urlResponse.statusCode)
            }
            
            let path = saveImageData(data: data)
            return (data, path)
    }
    
    private func saveImageData(data: Data) -> String {
        let uuid = UUID().uuidString
        let fileURL = FileHelper.getCacheDirectory().appending(path: uuid)
        let filePath = fileURL.path()
        FileManager.default.createFile(atPath: fileURL.path(), contents: data)
        return filePath
    }
}

actor ImageRepository {
    enum Constants {
        static let imageMapFilename = "imageMap"
    }
    static let shared = ImageRepository()
    
    let imageDownloader: ImageDownloaderProtocol
    var imageMap: [String: String]
    var saveWorkItem: DispatchWorkItem?
    
    init(imageDownloader: ImageDownloaderProtocol = ImageDownloader()) {
        self.imageDownloader = imageDownloader
        let documentDirectory = FileHelper.getDocumentDirectory()
        let fileURL = documentDirectory.appending(path: Constants.imageMapFilename)
        let data = try? Data(contentsOf: fileURL)
        guard let data else {
            self.imageMap = [:]
            return
        }
        self.imageMap = (try? JSONDecoder().decode([String: String].self, from: data)) ?? [:]
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(imageMap) {
            let documentDirectory = FileHelper.getDocumentDirectory()
            let fileURL = documentDirectory.appending(path: Constants.imageMapFilename)
            try? data.write(to: fileURL)
        }
    }
    
    func getImage(urlString: String) async -> UIImage? {
        let filePath = imageMap[urlString]
        if !FileHelper.fileExist(path: filePath) { // Images in the Cache directory could be remove by OS
            do {
                let (_, path) = try await imageDownloader.downloadImageData(urlString: urlString)
                imageMap[urlString] = path
                // Need debounced save() calling?
            } catch {
                return nil
            }
        }
        if let filePath = imageMap[urlString] {
            let fileURL = URL(filePath: filePath)
            guard let data = try? Data(contentsOf: fileURL) else { return nil }
            return UIImage(data: data)
        }
        return nil
    }
}
