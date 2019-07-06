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
    var assets: [Asset] { return repository.assets }
    private var currentAsset: Asset? {
        didSet {
            if let currentAsset = currentAsset {
                view?.updateAsset(currentAsset)
            }
        }
    }
    
    private let repository: LocalAssetRepositoryProtocol
    
    //MARK: - Public methods
    init(repository: LocalAssetRepositoryProtocol) {
        self.repository = repository
    }
    
    func onPlayerFailed(asset: Asset? = nil) {
        if let asset = asset {
            repository.removeFailedAsset(asset: asset)
        }
        nextAsset()
    }
    
    func onPlayerFinished() {
        nextAsset()
    }
    
    func nextAssetRequested() {
        nextAsset()
    }
    
    /// This method will reload video list and start playing the next song if possible
    func loadVideos() {
        // 1. reload UI's video list
        view?.updateAssets()
        // 2. Play item if it is not playing
        guard currentAsset == nil else { return }
        nextAsset()
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
