//
//  AssetRepository.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

struct AssetRepository {
    static var pendingDownloads: Set<Asset> {
        return UserDefaults.standard.getSet(forKey: UserDefaultsKeys.pendingDownloads) ?? Set()
    }
    
    static func fetch(payload: Payload) {
        let assets = pendingDownloads.union(payload.playlist) // Recover pending downloads
        assets.forEach { (asset) in
            UserDefaults.standard.saveInSet(value: asset, forKey:  UserDefaultsKeys.pendingDownloads)
            asset.makeRequest(completion: { result in
                switch result {
                case .success(let localUrl):
                    downloadSuccess(asset: asset, localURl: localUrl)
                case .failure(_):
                    downloadFailed(asset: asset)
                }
            })
        }
    }
    
    static private func downloadSuccess(asset: Asset, localURl: URL) {
        guard let destination = getDestinationPath(for: asset),
            moveFile(from: localURl, to: destination) else { return }
        
        let localAsset = Asset(id: asset.id, title: asset.title, subTitle: asset.subTitle, resource: destination)
        UserDefaults.standard.removeFromSet(value: asset, forKey: UserDefaultsKeys.pendingDownloads)
        UserDefaults.standard.saveInSet(value: localAsset, forKey:  UserDefaultsKeys.playlist)
        // Notify
        
    }
    
    static private func downloadFailed(asset: Asset) {
        UserDefaults.standard.removeFromSet(value: asset, forKey: UserDefaultsKeys.pendingDownloads)
        // Notify
    }
    
    static private func moveFile(from origin: URL, to destination: URL) -> Bool {
        do {
            try? FileManager.default.removeItem(at: destination)
            try FileManager.default.copyItem(at: origin, to: destination)
            NSLog("File copied to \(destination.absoluteString)")
            return true
        } catch {
            NSLog("MoveFile:%@", error.localizedDescription)
            return false
        }
    }
    
    static private func getDestinationPath(for asset: Asset) -> URL? {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard var documentsURL = url.first?.absoluteString else { return nil }
        
        if documentsURL.last != "/" {
            documentsURL.append("/")
        }
        
        let pathString = String(format: "%@%@.mp4", documentsURL, asset.id)
        return URL(string: pathString)
    }
}
