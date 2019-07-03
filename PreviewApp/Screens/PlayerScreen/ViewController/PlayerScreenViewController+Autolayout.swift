//
//  PlayerScreenViewController+Autolayout.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension PlayerScreenViewController {
    // vvv Declare all common constraints here vvv
    var horizontalPadding: CGFloat { return 24.0 }
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
        nowPlayingView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,
                                                constant: horizontalPadding).isActive = true
        nowPlayingView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,
                                                 constant: -horizontalPadding).isActive = true
        nowPlayingView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
    }
}
