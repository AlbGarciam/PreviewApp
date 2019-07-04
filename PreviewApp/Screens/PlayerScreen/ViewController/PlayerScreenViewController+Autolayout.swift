//
//  PlayerScreenViewController+Autolayout.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension PlayerScreenViewController {
    private var nowPlayingEstimatedSize: CGSize { return CGSize(width: 320, height: 180) }
    
    func configure() {
        addPlayerView()
        prepareNowPlaying()
        prepareCollectionView()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPanGesture(gesture:)))
        nowPlayingView.addGestureRecognizer(panGesture)
    }
    
    private func prepareNowPlaying() {
        nowPlayingView = NowPlayingView.create(frame: CGRect(origin: .zero, size: nowPlayingEstimatedSize))
        nowPlayingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nowPlayingView)
        
        topConstraint = nowPlayingView.topAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.topAnchor)
        topConstraint.isActive = true
        nowPlayingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        nowPlayingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = nowPlayingView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true
    }
    
    @objc private func onPanGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            initialBottomDistance = bottomConstraint.constant
        case .changed:
            let yTranslation = gesture.translation(in: view).y + initialBottomDistance
            let bottomDistance = bottomConstraint.constant
            let shouldCompress = bottomDistance < -(view.bounds.height / 2)
            if topConstraint.constant >= 0 {
                updateBottomConstraint(distance: yTranslation)
            }
            nowPlayingView.isCompressed = shouldCompress
            
        default:
            let shouldAnimate = bottomConstraint.constant > 0
            if shouldAnimate {
                resetBottomConstraint()
            }
        }
    }
    
    private func updateBottomConstraint(distance: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            self?.bottomConstraint.constant = distance
            self?.view.layoutIfNeeded()
        }
    }
    
    private func resetBottomConstraint() {
        DispatchQueue.main.async { [weak self] in
            self?.view.layoutIfNeeded()
            self?.bottomConstraint.constant = 0
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                self?.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
