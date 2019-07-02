//
//  PlayerScreenViewController.swift
//  PreviewApp
//
//  Template created by Alberto Garcia-Muñoz.
//  Linkedin: https://www.linkedin.com/in/alberto-garcia-munoz/
//  GitHub: https://github.com/AlbGarciam
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

class PlayerScreenViewController: UIViewController {
    
    var viewModel: PlayerScreenViewModel!
    
    //MARK: - UIComponents
    var playerView: PlayerView!
    
    var videoPlayer: VideoPlayer!
    
    var nowPlayingStackView: UIStackView!
    var nowPlayingTitleLabel: UILabel!
    var nowPlayingSubTitleLabel: UILabel!
    var progressView: CustomProgressBar!
    var durationLabel: UILabel!
    
    //MARK: - UI Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewReady()
    }
    
    //MARK: - UI private methods
    private func updateUI(for asset: Asset) {
        nowPlayingTitleLabel.text = asset.title
        if let text = asset.subTitle {
            nowPlayingSubTitleLabel.isHidden = false
            nowPlayingSubTitleLabel.text = text
        } else {
            nowPlayingSubTitleLabel.isHidden = true
        }
        nowPlayingStackView.layoutIfNeeded()
    }
    
    private func updatePlayer(for asset: Asset) {
        if let localFile = asset.localFile {
            videoPlayer = VideoPlayer(urlAsset: localFile, view: playerView)
            videoPlayer.delegate = self
        } else {
            viewModel.onAssetFailed(asset: asset)
        }
    }
}

//MARK: - ViewModel communication
protocol PlayerScreenViewControllerProtocol: class {
    func updateAsset(_ asset: Asset)
}

extension PlayerScreenViewController: PlayerScreenViewControllerProtocol {
    func updateAsset(_ asset: Asset) {
        updateUI(for: asset)
        updatePlayer(for: asset)
    }
}

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
