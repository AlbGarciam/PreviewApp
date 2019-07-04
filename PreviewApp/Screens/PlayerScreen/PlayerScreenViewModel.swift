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
    private(set) var assets: [Asset] = []
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
    
    func reloadDownloadedVideos() {
        assets = Array(AssetRepository.downloadedAssets).sorted()
        view?.updateAssets()
        loadVideo()
    }
    
    func asset(for position: Int) -> Asset? {
        guard position >= 0 && position < assets.count else { return nil }
        return assets[position]
    }
    
    func assetRequested(at position: Int) {
        guard position >= 0 && position < assets.count else { return }
        currentAsset = assets[position]
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
