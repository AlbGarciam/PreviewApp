//
//  Notification.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

struct Payload {
    let playlist: Playlist
    
    init(playlist: Playlist) {
        self.playlist = playlist
    }
}

extension Payload: Decodable {
    fileprivate enum CodingKeys: String, CodingKey {
        case playlist
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let playlist = try container.decode([String: RemoteAsset].self, forKey: .playlist)
        let items: [Asset] = playlist.compactMap { AssetMapper.map(($0, $1)) }
        self.init(playlist: Set.init(items))
    }
}

struct RemoteAsset : Decodable {
    let title: String
    let subtitle: String?
    let url: String
}
