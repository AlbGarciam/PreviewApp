//
//  FileManager.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

extension FileManager {
    var documentsURL: URL {
        let docs = urls(for: .documentDirectory, in: .userDomainMask)
        return docs.first! // iOS always has documents path
    }
    
    var documentsPath: String {
        var docsStr = documentsURL.absoluteString
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
        let pathString = "\(documentsPath)\(resourceName).\(filetype)"
        return URL(string: pathString)
    }
}
