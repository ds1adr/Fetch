//
//  FileHelper.swift
//  FetchTakeHome
//
//  Created by Wontai Ki on 2/28/25.
//

import Foundation

class FileHelper {
    static func fileExist(path: String?) -> Bool {
        guard let path else { return false }
        return FileManager.default.fileExists(atPath: path)
    }
    
    static func getCacheDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        guard let docPath = paths.first else {
            fatalError("Couldn't get document directory")
        }
        return docPath
    }
    
    static func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let docPath = paths.first else {
            fatalError("Couldn't get document directory")
        }
        return docPath
    }
}
