//
//  AssetRepository.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

struct AssetRepository {
    /// Pending assets, their download can be in progress
    static var pendingDownloads: Set<Asset> {
        return UserDefaults.standard.getSet(forKey: UserDefaultsKeys.pendingDownloads) ?? Set()
    }
    
    /// Fetchs all Assets from a given payload and reinitiates pending downloads
    ///
    /// - Parameter payload: Payload to be fetched
    static func fetch(payload: Payload, completion: @escaping () -> Void) {
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
                if pendingDownloads.isEmpty {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            })
            
        }
    }
    
    /// Moves the downloaded file from temp directory to documents directory
    ///
    /// - Parameters:
    ///   - asset: downloaded asset
    ///   - tempURL: temp url
    static private func downloadSuccess(asset: Asset, tempURL: URL) {
        let fileManager = FileManager.default
        let fileExtension = "mp4"
        let filename = "\(asset).\(fileExtension)"
        guard let destURL = fileManager.getDestinationPath(for: asset.description, filetype: fileExtension),
            fileManager.moveAndReplace(from: tempURL, to: destURL) else { return }
        UserDefaults.standard.removeFromSet(value: asset, forKey: UserDefaultsKeys.pendingDownloads)
        let localAsset = Asset(id: asset.id,
                               title: asset.title,
                               subTitle: asset.subTitle,
                               resource: asset.resource,
                               filename: filename)
        UserDefaults.standard.saveInSet(value: localAsset, forKey:  UserDefaultsKeys.downloadedAssets)
        // Notify
        
    }
    
    /// Removes asset from pending downloads because it can be assumed that the resource file cannot be downloaded
    ///
    /// - Parameter asset: Asset which has failed
    static private func downloadFailed(asset: Asset) {
        NSLog("Download failed: \(asset.resource)")
        UserDefaults.standard.removeFromSet(value: asset, forKey: UserDefaultsKeys.pendingDownloads)
        // Notify
    }
}
