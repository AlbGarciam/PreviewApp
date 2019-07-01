//
//  AssetMapper.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

struct AssetMapper : Mapper {
    typealias Input = (id: String, remote: RemoteAsset)
    typealias Output = Asset
    
    static func map(_ input: AssetMapper.Input) -> AssetMapper.Output? {
        guard let url = URL(string: input.remote.url) else { return nil }
        return Asset(id: input.id,
                     title: input.remote.title,
                     subTitle: input.remote.subtitle,
                     resource: url)
    }
}
