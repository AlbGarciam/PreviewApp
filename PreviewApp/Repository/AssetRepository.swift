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
                    downloadSuccess(asset: asset, tempURL: localUrl)
                case .failure(_):
                    downloadFailed(asset: asset)
                }
            })
        }
    }
    
    static private func downloadSuccess(asset: Asset, tempURL: URL) {
        let fileManager = FileManager.default
        guard let destURL = fileManager.getDestinationPath(for: asset.description, filetype: "mp4"),
            fileManager.moveAndReplace(from: tempURL, to: destURL) else { return }
        
        let localAsset = Asset(id: asset.id, title: asset.title, subTitle: asset.subTitle, resource: destURL)
        UserDefaults.standard.removeFromSet(value: asset, forKey: UserDefaultsKeys.pendingDownloads)
        UserDefaults.standard.saveInSet(value: localAsset, forKey:  UserDefaultsKeys.playlist)
        // Notify
        
    }
    
    static private func downloadFailed(asset: Asset) {
        UserDefaults.standard.removeFromSet(value: asset, forKey: UserDefaultsKeys.pendingDownloads)
        // Notify
    }
}
