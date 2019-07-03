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
    
    var videoPlayer: VideoPlayer?
    var nowPlayingView: NowPlayingView!
    
    var scrollView: UIScrollView!
    
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
        viewModel.loadVideo()
    }
    
    //MARK: - UI private methods
    
    private func updatePlayer(for asset: Asset) {
        if let localFile = asset.localFile {
            videoPlayer = VideoPlayer(urlAsset: localFile, view: playerView)
            videoPlayer?.delegate = self
        } else {
            viewModel.onPlayerFailed()
        }
    }
    
    @objc private func leftSwipePerformed() {
        viewModel.nextAssetRequested()
    }
}

//MARK: - ViewModel communication
protocol PlayerScreenViewControllerProtocol: class {
    func updateAsset(_ asset: Asset)
}

extension PlayerScreenViewController: PlayerScreenViewControllerProtocol {
    func updateAsset(_ asset: Asset) {
        nowPlayingView.update(asset: asset)
        updatePlayer(for: asset)
    }
}
