//
//  GradientView.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 03/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

typealias GradientColors = [CGColor]
typealias GradientLocations = [NSNumber]

class GradientView: UIView {
    
    var locations: GradientLocations
    var colors: GradientColors
    
    init(frame: CGRect, colors: GradientColors, locations: GradientLocations) {
        self.colors = colors
        self.locations = locations
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        locations = []
        colors = []
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let layer = self.layer as? CAGradientLayer
        layer?.colors = colors
        layer?.locations = locations
        layer?.frame = self.bounds
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
