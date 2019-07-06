//
//  LocalAssetRepositoryFake.swift
//  PreviewAppTests
//
//  Created by Alberto García-Muñoz on 06/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation
@testable import PreviewApp

//MARK: - Class
class LocalAssetRepositoryFake {
    private static let testUrl = URL(string: "https://static.xtrea.mr/media/sample1.mp4")!
    private static let firstAsset = Asset(id: "1", title: "", subTitle: nil,
                                          resource: testUrl, filename: "HelloWorld", insertDate: Date())
    private static let secondAsset = Asset(id: "2", title: "", subTitle: nil,
                                           resource: testUrl, filename: "HelloWorld",
                                           insertDate: Date(timeIntervalSinceNow: 50))
    private static let thirdAsset = Asset(id: "3", title: "", subTitle: nil,
                                           resource: testUrl, filename: "HelloWorld",
                                           insertDate: Date(timeIntervalSinceNow: 80))
    
    var assetToBeRemoved: Asset?
    private var mutableAssets: [Asset] = [firstAsset, secondAsset]
    
    func removeAllAssets() {
        mutableAssets.removeAll()
    }
    
    func addAssets() {
        mutableAssets.append(LocalAssetRepositoryFake.thirdAsset)
    }
}

//MARK: - Protocol
extension LocalAssetRepositoryFake: LocalAssetRepositoryProtocol {
    
    var assets: [Asset] { return mutableAssets.sorted() }
    
    func removeFailedAsset(asset: Asset) {
        assetToBeRemoved = asset
    }
    
}
