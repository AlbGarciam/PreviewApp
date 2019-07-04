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
    var nowPlayingCompressedTitleLabel: UILabel!
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
    
    var isCompressed: Bool {
        get { return viewModel.isCompressed }
        set { viewModel.isCompressed = newValue }
    }
    
    
    //MARK: - Private vars
    private var titleText: String { return nowPlayingTitleLabel.text ?? "" }
    private var subTitleText: String { return nowPlayingSubTitleLabel.text ?? "" }
    private var compressed: Bool { return nowPlayingTitleLabel.font == .Title }
    
}

//MARK: - ViewModel communication
protocol NowPlayingViewProtocol: class {
    var model: NowPlayingModel { get set }
}

extension NowPlayingView: NowPlayingViewProtocol {
    var model: NowPlayingModel {
        get { return NowPlayingModel(title: titleText, subTitle: subTitleText, isCompressed: compressed) }
        set {
            nowPlayingSubTitleLabel.isHidden = newValue.subTitle.isEmpty || newValue.isCompressed
            UIView.animate(withDuration: 0.25, delay: 0, options: .transitionCrossDissolve, animations: {
                self.nowPlayingTitleLabel.text = newValue.title
                self.nowPlayingSubTitleLabel.text = newValue.subTitle
                self.nowPlayingCompressedTitleLabel.text = newValue.title
                self.nowPlayingTitleLabel.isHidden = newValue.isCompressed
                self.nowPlayingCompressedTitleLabel.isHidden = !newValue.isCompressed
                self.nowPlayingStackView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    
}
