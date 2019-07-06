//
//  LocalAssetRepository.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 04/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

//MARK: - Class
class LocalAssetRepository {
    private var userDefaultsSet : Set<Asset>? {
        return userDefaults.getSet(forKey: UserDefaultsKeys.downloadedAssets)
    }
    
    private let userDefaults: UserDefaults
    private let fileManager: FileManager
    
    init(userDefaults: UserDefaults, fileManager: FileManager) {
        self.userDefaults = userDefaults
        self.fileManager = fileManager
    }
    
}

//MARK: - Protocol
extension LocalAssetRepository: LocalAssetRepositoryProtocol {
    
    var assets: [Asset] {
        guard let set = userDefaultsSet else { return [] }
        return Array(set).sorted()
    }
    
    func removeFailedAsset(asset: Asset) {
        if let localFile = asset.localFile, fileManager.fileExists(atPath: localFile.absoluteString) {
            do {
                try fileManager.removeItem(at: localFile)
            } catch {
                NSLog("Failed when removing file from: \(localFile.absoluteString). Reason: \(error.localizedDescription)")
            }
        }
        userDefaults.removeFromSet(value: asset, forKey: UserDefaultsKeys.downloadedAssets)
    }
    
}
//MARK: - Builder
extension LocalAssetRepository {
    static var standard: LocalAssetRepositoryProtocol {
        return LocalAssetRepository(userDefaults: .standard,
                                    fileManager: .default)
    }
}
