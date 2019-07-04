//
//  AssetCollectionViewCell.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 04/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

class AssetCollectionViewCell: UICollectionViewCell {
    static let reuseId: String = "AssetCollectionViewCell"
    private(set) var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addImageView()
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    private func addImageView() {
        imageView = UIImageView(frame: bounds)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
