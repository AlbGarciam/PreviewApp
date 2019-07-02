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
    
    //MARK: - Private methods
    
    
}

//MARK: - Extensions
