//
//  PlayerScreenViewController+Autolayout.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension PlayerScreenViewController {
    private var horizontalPadding: CGFloat { return 24.0 }
    func configure() {
        addPlayerView()
        addNowPlayingStackView()
        addNowPlayingTitleLabel()
        addNowPlayingSubTitleLabel()
        addDurationLabel()
        addProgressView()
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
    
    private func addNowPlayingStackView() {
        nowPlayingStackView = UIStackView(frame: CGRect(origin: .zero, size: CGSize(width: 320, height: 180))) // APROX
        nowPlayingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        nowPlayingStackView.axis = .vertical
        nowPlayingStackView.distribution = .equalSpacing
        nowPlayingStackView.spacing = 4
        
        view.addSubview(nowPlayingStackView)
        
        nowPlayingStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        nowPlayingStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,
                                                     constant: horizontalPadding).isActive = true
        nowPlayingStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,
                                                      constant: -horizontalPadding).isActive = true
    }
    
    private func addNowPlayingTitleLabel() {
        nowPlayingTitleLabel = UILabel(frame: nowPlayingStackView.bounds)
        
        nowPlayingTitleLabel.font = .Title
        nowPlayingTitleLabel.textColor = .DefaultColor
        nowPlayingTitleLabel.numberOfLines = 2
        
        nowPlayingStackView.addArrangedSubview(nowPlayingTitleLabel)
    }
    
    private func addNowPlayingSubTitleLabel() {
        nowPlayingSubTitleLabel = UILabel(frame: nowPlayingStackView.bounds)

        nowPlayingSubTitleLabel.font = .Subtitle
        nowPlayingSubTitleLabel.textColor = .DefaultColor
        nowPlayingSubTitleLabel.numberOfLines = 2
        
        nowPlayingStackView.addArrangedSubview(nowPlayingSubTitleLabel)
    }
    
    private func addDurationLabel() {
        durationLabel = UILabel(frame: nowPlayingStackView.bounds)
        
        durationLabel.font = .Subitem
        durationLabel.textAlignment = .right
        durationLabel.textColor = .DefaultColor
        durationLabel.numberOfLines = 1
        
        nowPlayingStackView.addArrangedSubview(durationLabel)
    }
    
    private func addProgressView() {
        progressView = CustomProgressBar(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: nowPlayingStackView.bounds.width,
                                                       height: CustomProgressBar.height))
        nowPlayingStackView.addArrangedSubview(progressView)
    }
}
