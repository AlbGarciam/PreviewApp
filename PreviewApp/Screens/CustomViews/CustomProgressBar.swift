//
//  CustomProgressBar.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

class CustomProgressBar: UIView {
    static let height: CGFloat = 6
    
    var progress: CGFloat = 0 {
        didSet {
            updateProgress(progress: progress)
        }
    }
    
    private var progressLayer: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        progressLayer = CALayer(layer: layer)
        autoresizingMask = [.flexibleWidth]
        
        configureLayer()
        configureProgressLayer()
        
        heightAnchor.constraint(equalToConstant: CustomProgressBar.height).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
        updateProgress(progress: progress)
    }
    
    override class var layerClass: AnyClass {
        return CALayer.self
    }
    
    private func configureLayer() {
        let backgroundColor = UIColor.LightGrayColor.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
        layer.borderColor = backgroundColor
        layer.backgroundColor = backgroundColor
        layer.masksToBounds = true
    }
    
    private func configureProgressLayer() {
        let backgroundColor = UIColor.DefaultColor.cgColor
        progressLayer.backgroundColor = backgroundColor
        progressLayer.masksToBounds = true
        
        layer.addSublayer(progressLayer)
        
        updateProgress(progress: progress)
    }
    
    private func updateProgress(progress: CGFloat) {
        let layerSize = layer.frame.size
        let size = CGSize(width: layerSize.width * progress, height: layerSize.height)
        
        progressLayer.frame = CGRect(origin: .zero, size: size)
        progressLayer.cornerRadius = progressLayer.frame.height / 2
    }
}
