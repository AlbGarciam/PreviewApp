//
//  PlayerScreenViewController+Autolayout.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension PlayerScreenViewController {
    func configure() {
        addPlayerView()
    }
    
    private func addPlayerView() {
        playerView = PlayerView(frame: view.bounds)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.backgroundColor = .black
        
        view.addSubview(playerView)
        
        playerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
