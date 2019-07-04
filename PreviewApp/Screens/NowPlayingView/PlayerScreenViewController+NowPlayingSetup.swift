//
//  PlayerScreenViewController+NowPlayingSetup.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 03/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension NowPlayingView {
    // vvv Declare all common constraints here vvv
    private var topPadding: CGFloat { return 32.0 }
    private var bottomPadding: CGFloat { return 16.0 }
    private var horizontalPadding: CGFloat { return 24.0 }
    
    func prepareNowPlaying() {
        clipsToBounds = false
        addBackgroundGradient()
        addNowPlayingStackView()
        addNowPlayingTitleLabel()
        addNowPlayingSubTitleLabel()
        addNowPlayingCompressedTitleLabel()
        addDurationLabel()
        addProgressView()
        layoutIfNeeded()
    }
    
    private func addBackgroundGradient() {
        backgroundGradient = GradientView(frame: bounds,
                                          colors: [UIColor.InitialGradient.cgColor, UIColor.FinalGradient.cgColor],
                                          locations: [0.0, 1.0])
        backgroundGradient.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundGradient)
        
        backgroundGradient.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundGradient.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundGradient.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundGradient.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func addNowPlayingStackView() {
        nowPlayingStackView = UIStackView(frame: bounds) // APROX
        nowPlayingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        nowPlayingStackView.axis = .vertical
        nowPlayingStackView.distribution = .equalSpacing
        nowPlayingStackView.spacing = 4
        
        addSubview(nowPlayingStackView)
        
        nowPlayingStackView.topAnchor.constraint(equalTo: topAnchor,
                                                 constant: topPadding).isActive = true
        nowPlayingStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: horizontalPadding).isActive = true
        nowPlayingStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                      constant: -horizontalPadding).isActive = true
        nowPlayingStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor,
                                                    constant: -bottomPadding).isActive = true
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
    
    private func addNowPlayingCompressedTitleLabel() {
        nowPlayingCompressedTitleLabel = UILabel(frame: nowPlayingStackView.bounds)
        
        nowPlayingCompressedTitleLabel.font = .Compressed
        nowPlayingCompressedTitleLabel.textColor = .DefaultColor
        nowPlayingCompressedTitleLabel.numberOfLines = 2
        
        nowPlayingStackView.addArrangedSubview(nowPlayingCompressedTitleLabel)
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
