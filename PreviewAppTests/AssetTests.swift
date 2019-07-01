//
//  AssetTests.swift
//  PreviewAppTests
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import XCTest
@testable import PreviewApp

class AssetTests: XCTestCase {

    var asset: Asset!
    let testUrl = URL(string: "https://static.xtrea.mr/media/sample1.mp4")!
    
    override func setUp() {
        asset = Asset(id: "test", title: "title", resource: testUrl)
    }

    func testAssetExistence() {
        XCTAssertNotNil(asset)
    }
    
    func testAssetIsHashable() {
        XCTAssertNotNil(asset.hashValue)
    }
    
    func testAssetWithSameIdAreTheSame() {
        let assetWithSameID = Asset(id: "test", title: "title2", resource: testUrl)
        XCTAssertEqual(assetWithSameID, asset)
    }
    
    func testAssetEncodeDecode() {
        let data = try? JSONEncoder().encode(asset)
        XCTAssertNotNil(data)
        let decoded = try? JSONDecoder().decode(Asset.self, from: data!)
        XCTAssertNotNil(decoded)
        XCTAssertEqual(asset.id, decoded!.id)
        XCTAssertEqual(asset.title, decoded!.title)
        XCTAssertEqual(asset.subTitle, decoded!.subTitle)
        XCTAssertEqual(asset.resource, decoded!.resource)
    }
    
}
