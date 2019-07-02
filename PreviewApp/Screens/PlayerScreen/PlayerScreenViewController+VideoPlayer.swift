//
//  PlayerScreenViewController+VideoPlayer.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension PlayerScreenViewController: VideoPlayerDelegate {
    
    func videoPlayer(_ player: VideoPlayer, didUpdatedProgress progress: Double) {
        let remaining = player.assetDuration - (progress * player.assetDuration)
        durationLabel.text = remaining.remainingSeconds
        progressView.progress = CGFloat(progress)
    }
    
    func didReachedEnd(_ player: VideoPlayer) {
        progressView.progress = 1
        videoPlayer = nil
        viewModel.onPlayerFinished()
    }
    
    func didFailedToReachEnd(_ player: VideoPlayer) {
        viewModel.onPlayerFailed()
    }
    
}
