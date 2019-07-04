//
//  PlayerScreenViewController+ScrollView.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 03/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension PlayerScreenViewController {
    func prepareCollectionView() {
        addCollectionView()
    }
    
    private func addCollectionView() {
        let layout = ColumnsCollectionFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.backgroundColor = .FinalGradient
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(AssetCollectionViewCell.self, forCellWithReuseIdentifier: AssetCollectionViewCell.reuseId)
        
        view.insertSubview(collectionView, belowSubview: nowPlayingView)
        
        collectionView.topAnchor.constraint(equalTo: nowPlayingView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension PlayerScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetCollectionViewCell.reuseId,
                                                      for: indexPath)
        if let _ = viewModel.asset(for: indexPath.item), let cell = cell as? AssetCollectionViewCell {
            // In case of future developments this image should be asset.image and it should come on payload data.
            // Meanwhile we are going to use a generic image
            cell.imageView.image = .DefaultAssetArtwork
        }
        return cell
    }
}

extension PlayerScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.assetRequested(at: indexPath.item)
    }
}
