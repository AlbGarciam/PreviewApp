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
    
    init?(json: JSON) {
        guard let playlist = json[CodingKeys.playlist.rawValue] as? JSON else { return nil }
        let list = playlist.compactMap { (key, value) -> Asset? in
            guard let value = value as? JSON,
                let remoteAsset = RemoteAsset(json: value) else { return nil }
            return AssetMapper.map((key, remoteAsset))
        }
        self.playlist = Set(list)
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

struct RemoteAsset: Decodable {
    let title: String
    let subtitle: String?
    let url: String
    
    fileprivate enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case url
    }
    
    init(title: String, subtitle: String?, url: String) {
        (self.title, self.subtitle, self.url) = (title, subtitle, url)
    }
    
    init?(json: JSON) {
        guard let title = json[CodingKeys.title.rawValue] as? String,
            let url = json[CodingKeys.url.rawValue] as? String else { return nil }
        let subtitle = json[CodingKeys.subtitle.rawValue] as? String
        self.init(title: title, subtitle: subtitle, url: url)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        let url = try container.decode(String.self, forKey: .url)
        self.init(title: title, subtitle: subtitle, url: url)
    }
}
