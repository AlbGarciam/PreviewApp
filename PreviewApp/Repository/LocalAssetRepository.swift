//
//  LocalAssetRepository.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 04/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

protocol LocalAssetRepositoryProtocol: AnyObject {
    var assets: [Asset] { get }
}

class LocalAssetRepository: LocalAssetRepositoryProtocol {
    /// Downloaded assets
    var assets: [Asset] {
        guard let set = userDefaultsSet else { return [] }
        return Array(set).sorted()
    }
    
    private var userDefaultsSet : Set<Asset>? { return UserDefaults.standard.getSet(forKey: UserDefaultsKeys.playlist) }
}
