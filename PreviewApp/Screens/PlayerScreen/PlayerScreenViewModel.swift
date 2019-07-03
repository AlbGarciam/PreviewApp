//
//  PlayerScreenViewModel.swift
//  PreviewApp
//
//  Template created by Alberto Garcia-Muñoz.
//  Linkedin: https://www.linkedin.com/in/alberto-garcia-munoz/
//  GitHub: https://github.com/AlbGarciam
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

class PlayerScreenViewModel {
    
    //MARK: - MVVM
    weak var view: PlayerScreenViewControllerProtocol?
    var router: PlayerScreenRouter?
    
    //MARK: - States
    private var assets: [Asset] {
        return Array(AssetRepository.downloadedAssets)
    }
    private var currentAsset: Asset? {
        didSet {
            if let currentAsset = currentAsset {
                view?.updateAsset(currentAsset)
            }
        }
    }
    
    //MARK: - Public methods
    
    func onPlayerFailed() {
        nextAsset()
    }
    
    func onPlayerFinished() {
        nextAsset()
    }
    
    func nextAssetRequested() {
        nextAsset()
    }
    
    func loadVideo() {
        guard currentAsset == nil else { return }
        nextAsset()
    }
    
    //MARK: - Private methods
    private func nextAsset() {
        var nextAsset = assets.first
        if let currentAsset = currentAsset, var position = assets.firstIndex(of: currentAsset) {
            position = (position + 1) % assets.count // Cannot be zero because position will be nil
            nextAsset = assets[position]
        }
        currentAsset = nextAsset
    }
}
