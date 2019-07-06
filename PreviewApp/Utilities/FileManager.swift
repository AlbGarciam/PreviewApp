//
//  FileManager.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

extension FileManager {
    var cacheURL: URL {
        let docs = urls(for: .cachesDirectory, in: .userDomainMask)
        return docs.first! // iOS always has cache path
    }
    
    var cachePath: String {
        var docsStr = cacheURL.absoluteString
        if docsStr.last != "/" {
            docsStr.append("/")
        }
        return docsStr
    }
    
    func moveAndReplace(from origin: URL, to destination: URL) -> Bool {
        do {
            try? removeItem(at: destination)
            try copyItem(at: origin, to: destination)
            NSLog("File copied to \(destination.absoluteString)")
            return true
        } catch {
            NSLog("MoveAndReplace:%@", error.localizedDescription)
            return false
        }
    }
    
    func getDestinationPath(for resourceName: String, filetype: String) -> URL? {
        let pathString = "\(cachePath)\(resourceName).\(filetype)"
        return URL(string: pathString)
    }
}
