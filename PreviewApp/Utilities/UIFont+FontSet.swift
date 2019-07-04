//
//  UIFont+FontSet.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 02/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

extension UIFont {
    static var Title: UIFont { return UIFont(font: .SFUIDisplay, weight: .light, size: 40)! }
    static var Subtitle: UIFont { return UIFont(font: .SFUIDisplay, weight: .bold, size: 32)! }
    static var Compressed: UIFont { return UIFont(font: .SFUIDisplay, weight: .light, size: 24)! }
    static var Parragraph: UIFont { return UIFont(font: .SFUIText, weight: .regular, size: 14)! }
    static var Subitem: UIFont { return UIFont(font: .SFUIText, weight: .heavy, size: 14)! }
    
    enum Font: String {
        case SFUIText = "SFUIText"
        case SFUIDisplay = "SFUIDisplay"
    }
    
    private static func name(of weight: UIFont.Weight) -> String? {
        switch weight {
        case .ultraLight: return "UltraLight"
        case .thin: return "Thin"
        case .light: return "Light"
        case .regular: return nil
        case .medium: return "Medium"
        case .semibold: return "Semibold"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        default: return nil
        }
    }
    
    convenience init?(font: Font, weight: UIFont.Weight, size: CGFloat) {
        var fontName = ".\(font.rawValue)"
        if let weightName = UIFont.name(of: weight) { fontName += "-\(weightName)" }
        self.init(name: fontName, size: size)
    }
}

