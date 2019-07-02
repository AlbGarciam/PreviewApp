//
//  Asset.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

struct Asset {
    let id: String
    let title: String
    let subTitle: String?
    let resource: URL
    let filename: String?
    
    var localFile: URL? {
        guard let filename = filename else { return nil }
        return URL(fileURLWithPath: filename, relativeTo: FileManager.default.documentsURL)
    }

    init(id: String, title: String, subTitle: String? = nil, resource: URL, filename: String? = nil) {
        (self.id, self.title, self.subTitle, self.resource, self.filename) = (id, title, subTitle, resource, filename)
    }
    
}

extension Asset: CustomStringConvertible {
    var description: String { return "\(id)" }
}

extension Asset: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Asset: Codable {
    fileprivate enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case resource
        case filename
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        let resource = try container.decode(URL.self, forKey: .resource)
        let filename = try container.decodeIfPresent(String.self, forKey: .filename)
        self.init(id: id, title: title, subTitle: subtitle, resource: resource, filename: filename)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(subTitle, forKey: .subtitle)
        try container.encode(resource.absoluteString, forKey: .resource)
        try container.encodeIfPresent(filename, forKey: .filename)
    }
}

extension Asset: Equatable {
    static func == (lhs: Asset, rhs: Asset) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Asset: DownloadRequest {
    var method: Methods { return .GET }
    var url: URL { return resource }
}
