//
//  PlayerScreenViewController+VideoPlayer.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension PlayerScreenViewController {
    func addPlayerView() {
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

extension PlayerScreenViewController: VideoPlayerDelegate {
    
    func videoPlayer(_ player: VideoPlayer, didUpdatedProgress progress: Double) {
        let remaining = player.assetDuration - (progress * player.assetDuration)
        nowPlayingView.update(remaining: remaining)
        nowPlayingView.update(progress: progress)
    }
    
    func didReachedEnd(_ player: VideoPlayer) {
        nowPlayingView.update(progress: 1)
        videoPlayer = nil
        viewModel.onPlayerFinished()
    }
    
    func didFailedToReachEnd(_ player: VideoPlayer) {
        viewModel.onPlayerFailed()
    }
    
}
