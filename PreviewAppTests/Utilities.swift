//
//  Utilities.swift
//  PreviewAppTests
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

struct Utilities {
    static func loadJSON(bundle: Bundle, from file: String) -> Data? {
        guard let path = bundle.path(forResource: file, ofType: "json") else {
            fatalError("Could not load file: \(file)")
        }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
}
