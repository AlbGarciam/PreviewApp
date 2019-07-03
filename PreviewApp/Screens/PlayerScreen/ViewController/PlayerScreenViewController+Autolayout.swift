//
//  PlayerScreenViewController+Autolayout.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension PlayerScreenViewController {
    private var nowPlayingEstimatedSize: CGSize { return CGSize(width: 320, height: 180) }
    
    func configure() {
        addPlayerView()
        prepareNowPlaying()
    }
    
    private func prepareNowPlaying() {
        nowPlayingView = NowPlayingView.create(frame: CGRect(origin: .zero, size: nowPlayingEstimatedSize))
        nowPlayingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nowPlayingView)
        
        nowPlayingView.topAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.topAnchor).isActive = true
        nowPlayingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        nowPlayingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        nowPlayingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
