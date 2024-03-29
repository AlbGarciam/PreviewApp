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
    
    var collectionView: UICollectionView!
    
    //MARK: - Gestures
    var panGesture: UIPanGestureRecognizer!
    
    //MARK: - Constraints
    var bottomConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint!
    
    var initialBottomDistance: CGFloat = 0
    
    //MARK: - UI Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Lifecycle
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipePerformed))
        leftSwipe.direction = .left
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(leftSwipe)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadVideos()
    }
    
    //MARK: - UI private methods
    
    private func updatePlayer(for asset: Asset) {
        if let localFile = asset.localFile {
            videoPlayer = VideoPlayer(urlAsset: localFile, view: playerView)
            videoPlayer?.delegate = self
        } else {
            viewModel.onPlayerFailed(asset: asset)
        }
    }
    
    @objc private func leftSwipePerformed() {
        viewModel.nextAssetRequested()
    }
}

//MARK: - ViewModel communication
protocol PlayerScreenViewControllerProtocol: class {
    func updateAsset(_ asset: Asset)
    func updateAssets()
}

extension PlayerScreenViewController: PlayerScreenViewControllerProtocol {
    func updateAsset(_ asset: Asset) {
        nowPlayingView.update(asset: asset)
        updatePlayer(for: asset)
    }
    
    func updateAssets() {
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
    }
}
