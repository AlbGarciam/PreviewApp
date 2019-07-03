//
//  NowPlayingViewController.swift
//  PreviewApp
//
//  Template created by Alberto Garcia-Muñoz.
//  Linkedin: https://www.linkedin.com/in/alberto-garcia-munoz/
//  GitHub: https://github.com/AlbGarciam
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

class NowPlayingView: UIView {
    static func create(frame: CGRect) -> NowPlayingView {
        let view = NowPlayingView(frame: frame)
        let viewModel = NowPlayingViewModel()
        
        view.viewModel = viewModel
        viewModel.view = view
        return view
    }
    
    var viewModel: NowPlayingViewModel!
    
    //MARK: - UIComponents
    var nowPlayingStackView: UIStackView!
    var nowPlayingTitleLabel: UILabel!
    var nowPlayingSubTitleLabel: UILabel!
    var progressView: CustomProgressBar!
    var durationLabel: UILabel!
    var backgroundGradient: GradientView!
    
    //MARK: - UI Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareNowPlaying()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func update(asset: Asset) {
        viewModel.asset = asset
    }
    
    func update(progress: Double) {
        progressView.progress = CGFloat(progress)
    }
    
    func update(remaining: Double) {
        durationLabel.text = remaining.remainingSeconds
    }
    
}

//MARK: - ViewModel communication
protocol NowPlayingViewProtocol: class {
    var titleText: String { get set }
    var subTitleText: String { get set }
}

extension NowPlayingView: NowPlayingViewProtocol {
    var titleText: String {
        get { return nowPlayingTitleLabel.text ?? "" }
        set {
            nowPlayingTitleLabel.text = newValue
            nowPlayingStackView.layoutIfNeeded()
        }
    }
    
    var subTitleText: String {
        get { return nowPlayingSubTitleLabel.text ?? "" }
        set {
            nowPlayingSubTitleLabel.isHidden = newValue.isEmpty
            nowPlayingSubTitleLabel.text = newValue
            nowPlayingStackView.layoutIfNeeded()
        }
    }
    
    
}
