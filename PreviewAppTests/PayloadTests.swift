//
//  PayloadTests.swift
//  PreviewAppTests
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import XCTest
@testable import PreviewApp

class PayloadTests: XCTestCase {
    
    func testAssetExistence() {
        let testUrl = URL(string: "https://static.xtrea.mr/media/sample1.mp4")!
        let asset = Asset(id: "test", title: "title", resource: testUrl)
        
        let set = Playlist(arrayLiteral: asset)
        let payload = Payload(playlist: set)
        XCTAssertNotNil(payload)
        XCTAssertEqual(payload.playlist.count, 1)
    }
    
    func testPlaylistDecodeWhenAllIsOk() {
        let data = Utilities.loadJSON(bundle: Bundle(for: type(of: self)), from: "SamplePayload")
        XCTAssertNotNil(data)
        do {
            let payload = try JSONDecoder().decode(Payload.self, from: data!)
            XCTAssertEqual(payload.playlist.count, 4)
        } catch {
            XCTFail("Cannot parse")
        }
    }

}
