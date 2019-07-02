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
    private let assets: Set<Asset>
    
    private var currentAssetPosition = 0
    
    //MARK: - Initializers
    init(assets: Set<Asset>) {
        self.assets = assets
    }
    
    //MARK: - Public methods
    func viewReady() {
        guard let initialAsset = assets.first else { return }
        view?.updateAsset(initialAsset)
    }
    
    func onAssetFailed(asset: Asset) {
        
    }
    
    func onPlayerFailed() {
        
    }
    
    func onPlayerFinished() {
        guard let next = nextAsset() else { return }
        view?.updateAsset(next)
    }
    
    //MARK: - Private methods
    
    private func nextAsset() -> Asset? {
        let shouldStartSequence = currentAssetPosition + 1 >= assets.count
        currentAssetPosition =  shouldStartSequence ? 0 : currentAssetPosition + 1
        guard currentAssetPosition >= 0 && currentAssetPosition < assets.count else { return nil}
        return Array(assets)[currentAssetPosition]
    }
}

//MARK: - Extensions
