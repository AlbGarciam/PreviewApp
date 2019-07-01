//
//  Mapper.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

protocol Mapper {
    associatedtype Input
    associatedtype Output
    
    static func map(_ input: Input) -> Output?
}
