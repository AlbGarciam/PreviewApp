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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipePerformed))
        leftSwipe.direction = .left
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(leftSwipe)
    }
    
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
    
    @objc private func leftSwipePerformed() {
        viewModel.finishAsset()
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
