//
//  AssetMapperTests.swift
//  PreviewAppTests
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import XCTest
@testable import PreviewApp

class AssetMapperTests: XCTestCase {
    
    func testAssetMapperWhenSubtitleIsNil() {
        let id = "test"
        let remoteAsset = RemoteAsset(title: "title test", subtitle: nil, url: "https://8.8.8.8")
        let asset = AssetMapper.map((id, remoteAsset))
        XCTAssertNotNil(asset)
        XCTAssertEqual(asset!.id, id)
        XCTAssertEqual(asset!.title, remoteAsset.title)
        XCTAssertEqual(asset!.subTitle, remoteAsset.subtitle)
        XCTAssertEqual(asset!.url.absoluteString, remoteAsset.url)
    }
    
    func testAssetMapperWhenSubtitleIsNotNil() {
        let id = "test"
        let remoteAsset = RemoteAsset(title: "title test", subtitle: "Not nil subtitle", url: "https://8.8.8.8")
        let asset = AssetMapper.map((id, remoteAsset))
        XCTAssertNotNil(asset)
        XCTAssertEqual(asset!.id, id)
        XCTAssertEqual(asset!.title, remoteAsset.title)
        XCTAssertEqual(asset!.subTitle, remoteAsset.subtitle)
        XCTAssertEqual(asset!.url.absoluteString, remoteAsset.url)
    }

}
