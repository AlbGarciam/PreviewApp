//
//  PlayerViewModelTests.swift
//  PreviewAppTests
//
//  Created by Alberto García-Muñoz on 06/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import XCTest
@testable import PreviewApp

class PlayerViewModelTests: XCTestCase {
    private let repository = LocalAssetRepositoryFake()
    var viewModel: PlayerScreenViewModel!
    
    fileprivate var updatedAsset: Asset?
    fileprivate var updateAssetsCalled: Bool = false
    
    override func setUp() {
        viewModel = PlayerScreenViewModel(repository: repository)
        viewModel.view = self
    }
    
    func testPlayerViewModelLoadVideoShouldUpdateWithFirstAssetWhenIsInitial() {
        viewModel.loadVideos()
        XCTAssertEqual(repository.assets.first, updatedAsset)
        XCTAssertTrue(updateAssetsCalled)
    }
    
    /// This test will emulate the case that we don't have videos and with app opened we receive a notification
    func testPlayerViewModelNotificationLoadVideoShouldUpdateVideoAfterAddingItemsWhenNoVideos() {
        repository.removeAllAssets()
        // No data
        viewModel.loadVideos()
        XCTAssertNil(updatedAsset)
        XCTAssertTrue(updateAssetsCalled)
        
        repository.addAssets()
        updateAssetsCalled = false
        
        viewModel.loadVideos()
        XCTAssertEqual(repository.assets.first, updatedAsset)
        XCTAssertTrue(updateAssetsCalled)
    }
    
    /// This test will emulate the case that we have videos and with app opened we receive a notification
    func testPlayerViewModelNotificationLoadVideoShouldUpdateVideoAfterAddingItemsWhenVideos() {
        // No data
        viewModel.loadVideos()
        XCTAssertNotNil(updatedAsset)
        XCTAssertTrue(updateAssetsCalled)
        
        repository.addAssets()
        updateAssetsCalled = false
        
        viewModel.loadVideos()
        XCTAssertEqual(repository.assets.first, updatedAsset)
        XCTAssertTrue(updateAssetsCalled)
    }
    
    /// This test will emulate the case that a video cannot be played so it should be removed
    func testPlayerViewModelShouldRemoveVideoWhenAssetDoesntHaveFilename() {
        // No data
        viewModel.loadVideos()
        XCTAssertNotNil(updatedAsset)
        XCTAssertTrue(updateAssetsCalled)
        
        updateAssetsCalled = false
        
        viewModel.onPlayerFailed(asset: updatedAsset)
        XCTAssertNotNil(repository.assetToBeRemoved)
        XCTAssertNotEqual(updatedAsset, repository.assetToBeRemoved)
        XCTAssertFalse(updateAssetsCalled)
    }
    
    func testPlayerViewModelShouldJumpVideoWhenItFailss() {
        // No data
        viewModel.loadVideos()
        XCTAssertNotNil(updatedAsset)
        XCTAssertTrue(updateAssetsCalled)
        
        updateAssetsCalled = false
        updatedAsset = nil
        
        viewModel.onPlayerFailed(asset: nil)
        XCTAssertNil(repository.assetToBeRemoved)
        XCTAssertNotNil(updateAssetsCalled)
        XCTAssertFalse(updateAssetsCalled)
    }
}

extension PlayerViewModelTests: PlayerScreenViewControllerProtocol {
    func updateAsset(_ asset: Asset) {
        updatedAsset = asset
    }
    
    func updateAssets() {
        updateAssetsCalled = true
    }
}
