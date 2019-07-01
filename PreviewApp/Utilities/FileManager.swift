//
//  FileManager.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

extension FileManager {
    
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
        let docs = urls(for: .documentDirectory, in: .userDomainMask)
        guard var docsStr = docs.first?.absoluteString else { return nil }
        
        if docsStr.last != "/" {
            docsStr.append("/")
        }
        
        let pathString = "\(docsStr)\(resourceName).\(filetype)"
        return URL(string: pathString)
    }
}
