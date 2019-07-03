//
//  NowPlayingViewModel.swift
//  PreviewApp
//
//  Template created by Alberto Garcia-Muñoz.
//  Linkedin: https://www.linkedin.com/in/alberto-garcia-munoz/
//  GitHub: https://github.com/AlbGarciam
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

class NowPlayingViewModel {
    
    //MARK: - MVVM
    weak var view: NowPlayingViewProtocol?
    
    //MARK: - States
    var asset: Asset? {
        didSet {
            let title = asset?.title ?? ""
            let subtitle = asset?.subTitle ?? ""
            view?.titleText = title
            view?.subTitleText = subtitle
        }
    }
    
}
