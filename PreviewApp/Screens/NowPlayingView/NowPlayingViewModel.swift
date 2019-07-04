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

typealias NowPlayingModel = (title: String, subTitle: String, isCompressed: Bool)

class NowPlayingViewModel {
    
    //MARK: - MVVM
    weak var view: NowPlayingViewProtocol?
    
    //MARK: - States
    var asset: Asset? {
        didSet {
            view?.model = buildUIModel(when: isCompressed)
        }
    }
    
    var isCompressed: Bool = false {
        didSet {
            guard oldValue != isCompressed else { return }
            view?.model = buildUIModel(when: isCompressed)
        }
    }
    
    private func buildUIModel(when compressed: Bool) -> NowPlayingModel {
        let title = compressed ? comressedText() : (asset?.title ?? "")
        let subTitle = compressed ? "" : (asset?.subTitle ?? "")
        return NowPlayingModel(title: title, subTitle: subTitle, isCompressed: isCompressed)
    }
    
    private func comressedText() -> String {
        let strings = [asset?.title, asset?.subTitle].compactMap { $0 }
        return strings.joined(separator: " ")
    }
}
