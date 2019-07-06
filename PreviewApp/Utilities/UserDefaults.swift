//
//  UserDefaults.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static let downloadedAssets: String = "cached_items"
    static let pendingDownloads: String = "pending_items"
}

extension UserDefaults {
    
    func getSet<Value: Codable & Hashable>(forKey key: String) -> Set<Value>? {
        guard let dataArray = data(forKey: key),
              let array = try? JSONDecoder().decode([Value].self, from: dataArray) else { return nil }
        return Set(array)
    }
    
    func saveSet<Value: Codable & Hashable>(_ value: Set<Value>, forKey key: String) {
        let array = Array(value)
        guard let data = try? JSONEncoder().encode(array) else { return }
        set(data, forKey: key)
    }
    
    func saveInSet<Value: Codable & Hashable>(value: Value, forKey key: String) {
        var set = getSet(forKey: key) ?? Set<Value>()
        set.insert(value)
        saveSet(set, forKey: key)
    }
    
    func removeFromSet<Value: Codable & Hashable>(value: Value, forKey key: String) {
        guard var set: Set<Value> = getSet(forKey: key) else { return }
        set.remove(value)
        saveSet(set, forKey: key)
    }
    
}
