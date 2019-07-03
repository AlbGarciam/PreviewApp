//
//  PlayerScreenViewController+NowPlayingSetup.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 03/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension NowPlayingView {

    func prepareNowPlaying() {
        addNowPlayingStackView()
        addNowPlayingTitleLabel()
        addNowPlayingSubTitleLabel()
        addDurationLabel()
        addProgressView()
    }
    
    private func addNowPlayingStackView() {
        nowPlayingStackView = UIStackView(frame: bounds) // APROX
        nowPlayingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        nowPlayingStackView.axis = .vertical
        nowPlayingStackView.distribution = .equalSpacing
        nowPlayingStackView.spacing = 4
        
        addSubview(nowPlayingStackView)
        
        nowPlayingStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nowPlayingStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nowPlayingStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nowPlayingStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
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
