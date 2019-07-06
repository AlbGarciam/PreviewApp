//
//  LocalAssetRepositoryProtocol.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 06/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

protocol LocalAssetRepositoryProtocol: AnyObject {
    /// Downloaded assets
    var assets: [Asset] { get }
    
    /// Removes a failed asset because it cannot be reproduced
    ///
    /// - Parameter asset: asset to be removed
    func removeFailedAsset(asset: Asset)
}
