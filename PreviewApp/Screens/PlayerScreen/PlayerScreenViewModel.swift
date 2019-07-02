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
    private let assets: [Asset]
    private var currentAsset: Asset! {
        didSet {
            view?.updateAsset(currentAsset)
        }
    }
    
    //MARK: - Initializers
    init(assets: Set<Asset>) {
        self.assets = Array(assets)
    }
    
    //MARK: - Public methods
    func viewReady() {
        guard let initialAsset = assets.first else { return }
        currentAsset = initialAsset
    }
    
    func onAssetFailed(asset: Asset) {
        loadNext()
    }
    
    func onPlayerFailed() {
        loadNext()
    }
    
    func onPlayerFinished() {
        loadNext()
    }
    
    func finishAsset() {
        loadNext()
    }
    
    //MARK: - Private methods
    
    private func loadNext() {
        guard let next = nextAsset() else { return }
        currentAsset = next
    }
    
    private func nextAsset() -> Asset? {
        guard !assets.isEmpty else { return nil }
        var position = assets.firstIndex(of: currentAsset) ?? 0
        position = (position + 1) % assets.count
        return assets[position]
    }
}

//MARK: - Extensions
